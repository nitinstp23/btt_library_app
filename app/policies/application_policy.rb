class ApplicationPolicy
  attr_reader :user, :record, :is_admin, :is_consumer

  def initialize(user, record)
    @user   = user
    @record = record

    @is_admin    = @user.is_a?(AdminUser)
    @is_consumer = @user.is_a?(Consumer)
  end

  def index?
    false
  end

  def show?
    scope.where(id: record.id).exists?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end

end
