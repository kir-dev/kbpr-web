class LinkPolicy < ApplicationPolicy
  def visit?
    without_login?
  end

  def disabled?
    without_login?
  end

  def show?
    member?
  end
  
  def index?
    member?
  end

  def create?
    admin?
  end

  def destroy?
    admin?
  end

  def update?
    admin?
  end

  def edit?
    update?
  end

  def new?
    create?
  end
end