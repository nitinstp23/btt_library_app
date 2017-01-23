class Consumer < ApplicationRecord
  has_secure_password

  validates :first_name, :last_name, presence: true
  validates :email, presence: true, email: true, uniqueness: true
  validates :password, length: { minimum: 8 }, allow_nil: true

  has_many :book_issues
end
