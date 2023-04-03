class StatisticPolicy < ApplicationPolicy
  def index?
    member?
  end

  def for_user?
    member?
  end

  def for_user_index?
    member?
  end

  def for_group?
    member?
  end

  def for_group_member?
    member?
  end
end

