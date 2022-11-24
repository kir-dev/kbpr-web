class ApplicationController < ActionController::Base
  skip_forgery_protection

  private

  def require_login
    # render :forbidden unless current_user.present?
  end
  def require_admin
    # render :forbidden unless current_user&.admin?
  end
end
