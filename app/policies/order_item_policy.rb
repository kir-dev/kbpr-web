class OrderItemPolicy < ApplicationPolicy
  def update?
    owner? || member?
  end

  def destroy?
    owner? || member?
  end

  def create?
    basic?
  end

  def index?
    member?
  end

  def order_image_input?
    new?
  end

  def my?
    basic?
  end

  def edit?
    update?
  end

  def new?
    basic?
  end

  def show?
    owner? || basic?
  end

  private

  def owner?
    return false if user.blank?
    user == record&.order&.user
  end
end
