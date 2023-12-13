class StatisticsController < ApplicationController
  require 'csv'
  before_action :set_fiscal_period, only: [:for_groups, :for_user_index, :for_user, :for_users]

  def for_groups
    @order_items = OrderItem.joins(:order).includes(order: :group)
                            .where(orders: { state: :complete })
                            .where('orders.finalized_at BETWEEN :start and :end',
                                   start: @fiscal_period.start_at.beginning_of_day,
                                   end: @fiscal_period.end_at.end_of_day)
    @groups_with_items = {}
    @order_items.each do |order_item|
      group = order_item.order.group
      item = order_item.item
      @groups_with_items[group] ||= {}
      @groups_with_items[group][item] ||= 0
      @groups_with_items[group][item] = @groups_with_items[group][item] + order_item.quantity
    end
    file_name = "kbpr_körös_nyomtatások_#{@fiscal_period.start_at.strftime('%F')}_#{@fiscal_period.end_at.strftime('%F')}.csv"
    respond_to do |format|
      format.html
      format.csv do
        csv = CSV.generate do |csv|
          @items = Item.all
          csv << ['Kör neve','Összeg'] + @items.pluck(:name)
          @groups_with_items.each do |group, items|
            line = [group.name]
            line << items.sum { |item, quantity| item.price * quantity }.to_i
            @items.each do |item|
              line << items[item]
            end
            csv << line
          end
        end
        send_data csv, disposition: "attachment; filename=#{file_name}"
      end
    end
  end

  def for_users
    @order_items = OrderItem.joins(:order).includes(order: :group)
                            .where(orders: { state: :complete })
                            .where('orders.finalized_at BETWEEN :start and :end',
                                   start: @fiscal_period.start_at.beginning_of_day,
                                   end: @fiscal_period.end_at.end_of_day)
    @users = {}
    @order_items.each do |order_item|
      user = order_item.order.completed_by
      item = order_item.item
      @users[user] ||= {}
      @users[user][item] ||= 0
      @users[user][item] = @users[user][item] + order_item.quantity
    end
    file_name = "kbpr_egyéni_nyomtatások_#{@fiscal_period.start_at.strftime('%F')}_#{@fiscal_period.end_at.strftime('%F')}.csv"
    respond_to do |format|
      format.html
      format.csv do
        csv = CSV.generate do |csv|
          @items = Item.all
          csv << ['Név','Összesen nyomtatva'] + @items.pluck(:name)
          @users.each do |user, items_from_orders|
            line = [user.name]
            line << "soonTM"
            items_from_orders.each do |item, quantity|
              line << quantity
            end
            csv << line
          end
        end
        send_data csv, disposition: "attachment; filename=#{file_name}"
      end
    end
  end

  def for_group
    @group = Group.find(params[:group_id])
    @orders = Order.includes(:order_items).with_total_price
                   .where(group: @group, state: :complete)
                   .group('order_items.id')
  end

  def for_group_member
    @group = Group.find(params[:group_id])
    @orders = Order.includes(:order_items).with_total_price
                   .where(group: @group, state: :complete)
                   .group('order_items.id')

    @members = Hash.new
    @orders.each do |order|
      @members[order.user] = Hash.new if @members[order.user].nil?
      order.order_items.each do |order_item|
        number = @members[order.user][order_item.item]
        number = 0 if number.nil?
        number += order_item.quantity
        @members[order.user][order_item.item] = number
      end
    end
  end

  def for_user_index
    user_stat
  end

  def for_user
    user_stat
    @user = User.find(params[:user_id])
    @stat = @users[@user]
  end

  private

  def set_fiscal_period
    @fiscal_periods = FiscalPeriod.all.order(id: :desc)
    @fiscal_periods = @fiscal_periods.to_a.unshift(FiscalPeriod.new(id: '-1', name: 'Egyedi'))
    @fiscal_period = search_fiscal_period
  end

  def fiscal_period_id
    params[:fiscal_period_id]
  end

  def user_stat
    @order_items = OrderItem.joins(:order).includes(:item, order: :completed_by)
                            .where('orders.completed_at BETWEEN :start and :end',
                                   start: @fiscal_period.start_at, end: @fiscal_period.end_at)
    @users = {}
    @order_items.each do |order_item|
      user = order_item.order.completed_by
      item = order_item.item
      @users[user] ||= {}
      @users[user][item] ||= 0
      @users[user][item] = @users[user][item] + order_item.quantity
    end
  end

  def search_fiscal_period
    if fiscal_period_id == '-1'
      FiscalPeriod.new(id: -1, start_at: params[:start_at], end_at: params[:end_at])
    elsif fiscal_period_id.present?
      FiscalPeriod.find(fiscal_period_id)
    else
      FiscalPeriod.last
    end
  end
end
