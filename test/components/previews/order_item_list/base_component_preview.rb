# frozen_string_literal: true

class OrderItemList::BaseComponentPreview < ViewComponent::Preview
  def default
    render(OrderItemList::BaseComponent.new(order_items: Order.last.order_items))
  end
end
