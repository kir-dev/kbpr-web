class StatisticsController < ApplicationController

  before_action :require_admin, only: [:index, :for_group, :for_group_member]
  
  def index
    @fiscal_periods = FiscalPeriod.all.order(id: :desc)
    @fiscal_periods = @fiscal_periods.to_a.unshift(FiscalPeriod.new(id: '-1', name: 'Egyedi'))
    @fiscal_period = search_fiscal_period
    @group_total_prices = Group.price_for(
      OrderItem.all.joins(:order)
               .where(order: { state: :complete })).
      where('orders.finalized_at BETWEEN :start and :end',
            start: @fiscal_period.start_at.beginning_of_day, end: @fiscal_period.end_at.end_of_day)
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

  def fiscal_period_id
    params[:fiscal_period_id]
  end

  def user_stat
    @fiscal_period = fiscal_period_id ? FiscalPeriod.find(fiscal_period_id) : FiscalPeriod.last
    @order_items = OrderItem.joins(:order).includes(:item, order: :completed_by)
                            .where('orders.finalized_at BETWEEN :start and :end',
                                   start: @fiscal_period.start_at, end: @fiscal_period.end_at)
    @users = {}
    @order_items.each do |order_item|
      user = order_item.order.completed_by
      item = order_item.item
      @users[user] ||= {}
      @users[user][item] ||= 0
      @users[user][item] = @users[user][item] + order_item.quantity
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
