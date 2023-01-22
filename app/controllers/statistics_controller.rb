class StatisticsController < ApplicationController
  before_action :require_admin, only: [:index, :for_group]
  def index
    @group_total_prices = Group.price_for(OrderItem.all.joins(:order).where(order: {state: :complete}))
  end

  def for_group
    @group = Group.find(params[:group_id])
    @orders = Order.includes(:order_items).where(group: @group, state: :complete)
  end
end
