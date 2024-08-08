class PagePolicy < ApplicationPolicy
  def home?
    without_login?
  end

  def admin?
    super
  end

  def howto?
    without_login?
  end

  def profile?
    basic?
  end
end
