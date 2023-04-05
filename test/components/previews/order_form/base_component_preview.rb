# frozen_string_literal: true

class OrderForm::BaseComponentPreview < ViewComponent::Preview
  include Turbo::FramesHelper

  def default
    order = Order.new
    render(OrderForm::BaseComponent.new(order: order))
  end
end
