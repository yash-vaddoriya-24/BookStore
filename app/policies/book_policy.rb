class BookPolicy < ApplicationPolicy
  def show?
    true
  end

  def edit?
    user.has_role?(:admin)
  end

  def update?
    edit?
  end

  def destroy?
    user.has_role?(:admin)
  end
end
