class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy new_item create_item update_item all_item finalize complete]
  before_action :require_login
  before_action :require_admin, except: [:finalize, :new, :create, :new_item, :create_item, :update_item, :all_item, :delete_item]
  # GET /orders or /orders.json
  def index
    search_attributes = {state: params.dig(:order, :state)|| :processing}
    @search_order = Order.new(search_attributes)
    @orders = Order.where(search_attributes).order(finalized_at: :asc)
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
    @order.update(order_params)
    if @order.update(state: :processing, finalized_at: Time.current)

      redirect_to root_path, notice: "Rendelés sikeresen leadva!"
    else
      redirect_to new_order_path(process: true)
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
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
    @order.update!(deleted: true)

    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def complete
    @order.update!(state: :complete, completed_at: Time.current)
    redirect_to orders_url, notice: "A rendelés elkészült!"
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.require(:order).permit(:group_id, :link, :print_quantity, :paper_size, :comment, :sticker, :laminated,
                                  :printed_by_me, :has_sch_logo, :has_right_format,
                                  :has_date, :accepted_terms_of_service)
  end
end
