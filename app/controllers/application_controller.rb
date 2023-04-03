class ApplicationController < ActionController::Base
  UNAUTHORIZED_CONTROLLERS = ['omniauth_callbacks', 'sessions']
  include Pundit::Authorization
  before_action :basic_authorization, if: -> { authorized_controller?  }
  after_action :verify_authorized, if: -> { authorized_controller? }
  rescue_from Pundit::NotAuthorizedError, with: :unauthorized_page
  skip_forgery_protection

  def unauthorized_page
    render 'unauthorized', status: :unauthorized
  end

  private

  def  authorized_controller?
    UNAUTHORIZED_CONTROLLERS.exclude?(controller_name)
  end

  def basic_authorization
    return if params.has_key?('id')

    authorize controller_name.singularize.to_sym, action_name + '?'
  end
end
