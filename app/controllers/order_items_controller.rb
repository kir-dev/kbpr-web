class OrderItemsController < ApplicationController
  before_action :set_order, only: [:index, :new]
  before_action :set_order_item, only: [:edit, :update, :destroy]

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

  def create
    @order_item = OrderItem.new(order_item_params)
    @order_item.price = @order_item.item&.price
    if @order_item.save
      @order_item = OrderItem.new(order: @order_item.order)
      broadcast_order_update
      render(OrderItemCreateForm::BaseComponent.new(order_item: @order_item,
                                                    success: true),
             content_type: "text/html")

    else
      render(OrderItemCreateForm::BaseComponent.new(order_item: @order_item),
             content_type: "text/html")
    end
  end

  def edit
    authorize @order_item
  end

  def update
    authorize @order_item
    if @order_item.update(order_item_params)
      broadcast_order_update
      return
    else
      render partial: 'edit_form', locals: { order_item: @order_item }
    end
  end

  def destroy
    authorize @order_item
    @order_item.destroy!
    broadcast_order_update
  end

  def order_image_input; end

  private

  def set_order
    @order = Order.find(params[:order_id])
  end

  def set_order_item
    @order_item = OrderItem.find(params[:id])
  end

  def order_item_params
    params.require(:order_item).permit(:order_id, :quantity, :item_id, :laminated, :comment, :price, :order_image)
  end

  def broadcast_order_update
    OrderChannel.broadcast_to(current_user,
                              { order_total_price: @order_item.order.total_price })
  end
end
