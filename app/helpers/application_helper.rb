module ApplicationHelper
  def admin?
    current_user&.admin?
  end

  def member?
    current_user&.admin? || current_user&.member?
  end
end
