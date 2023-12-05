class PostPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user&.admin? 
        scope.all
      else
        scope.where(user: user).or(scope.published)
      end
    end
  end

  def show?
    true
  end

  def new?
    show?
  end

  def create?
    new?
  end

  def edit?
    user_or_admin?
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

  private

  def user_or_admin?
    user == record.user || user&.admin
  end
end
