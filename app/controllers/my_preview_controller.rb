# frozen_string_literal: true

class MyPreviewController < ActionController::Base
  include ViewComponent::PreviewActions
  include Pundit::Authorization
end
