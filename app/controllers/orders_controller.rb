class OrdersController < ApplicationController
  include OrdersHelper
  before_action :set_order, only: %i[ show edit update destroy new_item create_item update_item all_item finalize complete]
  # skip_before_action :basic_authorization, only: [:finalize, :update]
  # GET /orders or /orders.json
  def index
    search_attributes = {state: params.dig(:order, :state)|| :processing,}
    @search_order = Order.new(search_attributes)
    @orders = Order.joins(order_items: :item)
                   .where(search_attributes)

    if params[:item_id].present?
      @orders = @orders.where(order_items: { item_id: params.dig(:order, :item_id) })
    end

    if params[:completed_by_id].present?
      @orders = @orders.where(completed_by_id: { completed_by_id: params.dig(:order, :completed_by_id) })
    end

    @orders = @orders.order(finalized_at: :desc).page(params[:page])
  end

  def my_orders
    @orders = current_user.orders.where.not(state: :draft)
  end

  # GET /orders/1 or /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = current_user.current_order || Order.create!(user: current_user)
    if params[:process]
      @order.state = :processing
      @order.validate
    end
  end

  # GET /orders/1/edit
  def edit
    authorize @order
  end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params.merge({ user_id: current_user.id }))

    respond_to do |format|
      if @order.save
        format.html { redirect_to root_path, notice: "Rendelés sikeresen leadva!" }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def finalize
    authorize @order
    @order.update(order_params)
    if @order.update(state: :processing, finalized_at: Time.current)

      redirect_to root_path, notice: "Rendelés sikeresen leadva!"
      send_notification(order_params)
    else
      redirect_to new_order_path(process: true)
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    authorize @order
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to orders_url, notice: "A rendelést sikeresen mentve!" }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    authorize @order
    @order.update!(deleted: true)

    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def complete
    authorize @order
    @order.update!(state: :complete, completed_at: Time.current, completed_by: current_user)
    redirect_to orders_url, notice: "A rendelés elkészült!"
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.require(:order).permit(:group_id, :link, :print_quantity, :paper_size, :comment, :sticker,
                                  :printed_by_me, :has_sch_logo, :has_right_format,
                                  :has_date, :accepted_terms_of_service)
  end
end
