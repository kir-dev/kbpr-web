# frozen_string_literal: true

class OrderItemList::BaseComponent < ViewComponent::Base
  def initialize(order:)
    @order = order
  end

end
