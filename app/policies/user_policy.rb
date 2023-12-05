class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all if record.admin
    end
  end

  def show?
    true
  end

  def new?
    user_or_admin?
  end
  
  def create?
    new?
  end

  def edit?
    new?
  end

  def update?
    new?
  end

  def destroy?
    new?
  end

  private

  def user_or_admin?
    user == record || user == record.user || user&.admin
  end
end
