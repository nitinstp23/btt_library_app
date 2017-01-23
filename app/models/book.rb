class Book < ApplicationRecord

  validates :title, :author, presence: true
  validates :isbn, presence: true, uniqueness: { case_sensitive: false }
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }

  has_many :book_issues

  before_save :upcase_isbn

  private

  def upcase_isbn
    self.isbn = self.isbn.upcase
  end

end
