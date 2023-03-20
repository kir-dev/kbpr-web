class StatisticsController < ApplicationController
  before_action :require_admin, only: [:index, :for_group, :for_group_member]
  def index
    @fiscal_period = fiscal_period_id ? FiscalPeriod.find(fiscal_period_id):FiscalPeriod.last

    @group_total_prices = Group.price_for(
      OrderItem.all.joins(:order)
               .where(order: {state: :complete})).
      where('orders.finalized_at BETWEEN :start and :end',
            start: @fiscal_period.start_at, end: @fiscal_period.end_at)
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

  private

  def fiscal_period_id
    params[:fiscal_period_id]
  end
end
