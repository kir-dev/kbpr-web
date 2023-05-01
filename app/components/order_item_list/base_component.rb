# frozen_string_literal: true

class OrderItemList::BaseComponent < ViewComponent::Base
  include Turbo::FramesHelper
  private attr_reader :order_items
  def initialize(order_items:)
    @order_items = order_items
  end

end
