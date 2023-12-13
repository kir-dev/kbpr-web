class StatisticPolicy < ApplicationPolicy
  def for_groups?
    member?
  end

  def for_users?
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

