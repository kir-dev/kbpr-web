class OrderItemsController < ApplicationController
  before_action :set_order, only: [:index, :new, :create]
  before_action :set_order_item, only: [:edit, :update]

  def index
    @orders = Order.all
    # @order.state = :processing
  end

  def my
    @orders = current_user.orders
  end

  def show
  end

  def new
  end

  def stats
    @group_total_prices = Group.price_for(OrderItem.all.joins(:order).where(order: {state: :complete}))
  end

  def stats_for_group
    @group = Group.find(params[:group_id])
    @orders = Order.includes(:order_items).where(group: @group, state: :complete)
  end

  def create
    @order_item = OrderItem.new(order_item_params)
    @order_item.order = @order
    @order_item.price = @order_item.item&.price
    if @order_item.save
      @order_item = nil # close editform
    end
  end

  def edit

  end

  def update
    if @order_item.update(order_item_params)
      broadcast_order_update
      return
    else
      render partial: 'edit_form', locals: { order_item: @order_item }
    end
  end

  def destroy
    @order_item = OrderItem.find(params[:id])
    @order_item.destroy!
    broadcast_order_update
  end

  private

  def set_order
    @order = Order.find(params[:order_id])
  end

  def set_order_item
    @order_item = OrderItem.find(params[:id])
  end

  def order_item_params
    params.require(:order_item).permit(:link, :quantity, :item_id, :laminated)
  end

  def broadcast_order_update
    OrderChannel.broadcast_to(current_user,
                              { order_total_price: @order_item.order.total_price })
  end
end