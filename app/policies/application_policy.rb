# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  private
  def admin?
    user&.admin?
  end

  def member?
    user&.member? || admin?
  end

  def basic?
    user&.basic? || member?
  end

  def owner?
    # return false if record.blank? || user.blank?
    return false unless record.is_a? ApplicationRecord
    user == record&.user
  end

  def without_login?
    true
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NotImplementedError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end
end
