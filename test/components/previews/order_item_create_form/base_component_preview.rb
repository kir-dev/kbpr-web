# frozen_string_literal: true

class OrderItemCreateForm::BaseComponentPreview < ViewComponent::Preview
  def default
    render(OrderItemCreateForm::BaseComponent.new(order_item: OrderItem.new(order: Order.last)))
  end
end
