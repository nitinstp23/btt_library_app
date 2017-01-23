class BookIssue < ApplicationRecord

  belongs_to :book
  belongs_to :consumer

  validates :book, :consumer, :issued_at, presence: true
  validates_uniqueness_of :book_id, scope: :consumer_id

  before_save :set_due_date

  private

  def set_due_date
    self.due_date = self.issued_at
                        .advance(days: BttLibraryApp::DUE_DATE_PERIOD)
                        .to_date
  end

end
