class StatisticsController < ApplicationController
  before_action :require_admin, only: [:index, :for_group]

  def index

    @fiscal_periods = FiscalPeriod.all.order(id: :desc)
    @fiscal_periods = @fiscal_periods.to_a.unshift(FiscalPeriod.new(id: '-1', name: 'Egyedi'))
    @fiscal_period = search_fiscal_period
    @group_total_prices = Group.price_for(
      OrderItem.all.joins(:order)
               .where(order: { state: :complete })).
      where('orders.finalized_at BETWEEN :start and :end',
            start: @fiscal_period.start_at, end: @fiscal_period.end_at)
  end

  def for_group
    @group = Group.find(params[:group_id])
    @orders = Order.includes(:order_items).with_total_price
                   .where(group: @group, state: :complete)
                   .group('order_items.id')
  end

  private

  def fiscal_period_id
    params[:fiscal_period_id]
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
