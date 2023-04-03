class ItemPolicy < ApplicationPolicy
  def index?
    member?
  end

  def show?
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
