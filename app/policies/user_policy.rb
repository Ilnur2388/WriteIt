class UserPolicy < ApplicationPolicy
  def update?
    record == user
  end

  def index?
    false
  end

  def new?
    true
  end

  def create?
    true
  end

  def destroy?
    false
  end
end
