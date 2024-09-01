class KwcPolicy < ApplicationPolicy
  def current?
    basic?
  end

  def update_current?
    basic?
  end

  def index?
    member?
  end
  
  def reset?
    admin?
  end
end
