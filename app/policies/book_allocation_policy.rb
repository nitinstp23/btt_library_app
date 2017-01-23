class BookAllocationPolicy < ApplicationPolicy

  def new?
    is_admin
  end

  def create?
    is_admin
  end

end
