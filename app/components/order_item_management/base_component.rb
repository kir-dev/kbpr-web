# frozen_string_literal: true

class OrderItemManagement::BaseComponent < ViewComponent::Base
  include Turbo::FramesHelper

  attr_reader :order, :new_order_item

  def initialize(order:)
    @order = order
    @new_order_item = OrderItem.new(order: order)
  end

  def component_controller
    "order-item-management--base-component"
  end

  def component_target
    "data-#{component_controller}-target"
  end

  def url
    root_path
  end
end
