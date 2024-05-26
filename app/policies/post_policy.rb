class PostPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user.present?
  end

  def update?
    user.author?(record)
  end

  def destroy?
    user.author?(record)
  end
end
