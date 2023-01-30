class ApplicationController < ActionController::Base
  skip_forgery_protection

  private

  def require_login
    render :unauthorized unless current_user.present?
  end
  def require_admin
    render :forbidden unless current_user&.admin?
  end

  def require_member
    render :forbidden unless current_user&.admin? || current_user&.member?
  end
end
