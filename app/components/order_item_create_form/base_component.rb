# frozen_string_literal: true

class OrderItemCreateForm::BaseComponent < ViewComponent::Base
  include Turbo::FramesHelper

  attr_reader :order, :new_order_item

  def initialize(order_item:)
    @order = order_item.order
    @new_order_item = order_item
  end

  private
  def component_controller
    "order-item-create-form--base-component"
  end

  def component_target
    "data-#{component_controller}-target"
  end

  def url
    order_items_path
  end

  def hidden
    return false if new_order_item.errors.present?

    true
  end
end
