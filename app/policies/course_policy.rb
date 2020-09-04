class CoursePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user: user)
      end
    end
  end

  def distance?
    true
  end

  def create?
    true
  end

  def show?
    user_is_owner_or_admin
  end

  def destroy?
    user_is_owner_or_admin
  end

  private

  def user_is_owner_or_admin
    record.user == user || user.admin?
  end
end
