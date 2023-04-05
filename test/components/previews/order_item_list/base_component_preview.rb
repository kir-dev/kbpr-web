# frozen_string_literal: true

class OrderItemList::BaseComponentPreview < ViewComponent::Preview
  def default
    render(OrderItemList::BaseComponent.new(order: "order"))
  end
end
