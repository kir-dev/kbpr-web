class PagePolicy < ApplicationPolicy
  def home?
    without_login?
  end

  def admin?
    super
  end

  def profile?
    basic?
  end
end
