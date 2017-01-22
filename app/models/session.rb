class Session
  include ActiveModel::Model

  attr_accessor :email, :password, :is_admin

  validates :email, :password, presence: true
  validates :email, email: true
  validate :user_authenticity

  def initialize(attributes = {})
    @email    = attributes[:email]
    @password = attributes[:password]
    @is_admin = attributes.fetch(:is_admin, false)
  end

  def user_id
    user.id
  end

  def user_type
    user.class.to_s
  end

  private

  def user_authenticity
    return if user.authenticate(password)
    self.errors.add(:base, I18n.t('session.authentication.invalid'))
  end

  def user
    @user ||= begin
      if is_admin
        AdminUser.where(email: email).first
      else
        Consumer.where(email: email).first
      end || NullUser.new
    end
  end
end
