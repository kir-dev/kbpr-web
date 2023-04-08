# frozen_string_literal: true

class OrderItemCreateForm::BaseComponent < ViewComponent::Base
  include Turbo::FramesHelper

  attr_reader :order, :new_order_item, :success

  def initialize(order_item:, form_hidden: nil, success: false )
    @order = order_item.order
    @new_order_item = order_item
    @form_hidden = form_hidden
    @success = success
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

  def form_hidden
    return @form_hidden unless @form_hidden.nil?
    return false if new_order_item.errors.present?

    true
  end
end
