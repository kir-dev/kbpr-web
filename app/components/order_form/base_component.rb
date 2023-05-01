# frozen_string_literal: true

class OrderForm::BaseComponent < ViewComponent::Base
  private attr_reader :order
  include Turbo::FramesHelper

  def initialize(order:)
    @order = order
  end

  def url
    order_form_component_submit_path
  end
end
