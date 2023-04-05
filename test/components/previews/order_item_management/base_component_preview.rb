# frozen_string_literal: true

class OrderItemManagement::BaseComponentPreview < ViewComponent::Preview
  def default
    render(OrderItemManagement::BaseComponent.new(order: Order.last))
  end
end
