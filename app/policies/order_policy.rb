class OrderPolicy < ApplicationPolicy
  def show?
    member?
  end

  def complete?
    member?
  end

  def update?
    owner? || member?
  end

  def destroy?
    member?
  end

  def create?
    basic?
  end

  def finalize?
    owner?
  end

  def index?
    member?
  end

  def my_orders?
    basic?
  end

  def edit?
    owner? || member?
  end

  def new?
    basic?
  end

  def complete?
    member?
  end
end
