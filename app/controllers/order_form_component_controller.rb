class OrderFormComponentController < ApplicationController
  before_action :set_order, only: %i[submit]

  def submit
    @order.update(order_params)

    if @order.update(state: :processing, finalized_at: Time.current)
      redirect_to root_path, notice: "Rendelés sikeresen leadva!"
    else
      render OrderForm::BaseComponent.new(order: @order), content_type: "text/html"
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:order][:id])
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.require(:order).permit(:group_id, :link, :print_quantity, :paper_size, :comment, :sticker, :laminated,
                                  :printed_by_me, :has_sch_logo, :has_right_format,
                                  :has_date, :accepted_terms_of_service)
  end
end
