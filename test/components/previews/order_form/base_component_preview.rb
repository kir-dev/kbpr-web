# frozen_string_literal: true

class OrderForm::BaseComponentPreview < ViewComponent::Preview
  include Turbo::FramesHelper

  def default
    order = Order.last
    render(OrderForm::BaseComponent.new(order: order))
  end
end
