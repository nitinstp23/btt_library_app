class BookPolicy < ApplicationPolicy

  def index?
    is_admin || is_consumer
  end

  def new?
    is_admin
  end

  def create?
    is_admin
  end

  def show?
    is_admin || is_consumer
  end

  def edit?
    is_admin
  end

  def update?
    is_admin
  end

  def destroy?
    is_admin
  end

end
