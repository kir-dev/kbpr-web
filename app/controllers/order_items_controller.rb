class OrderItemsController < ApplicationController
  before_action :set_order, only: [:index, :new, :create]
  before_action :set_order_item, only: [:edit, :update]

  def index
    @orders = Order.all
    @order = @order.processing
  end

  def show
  end

  def new
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
      return
    else
      render partial: 'edit_form', locals: { order_item: @order_item }
    end
  end

  def destroy
    @order_item = OrderItem.find(params[:id])
    @order_item.destroy!
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
end
