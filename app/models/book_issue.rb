class BookIssue < ApplicationRecord

  belongs_to :book
  belongs_to :consumer

  validates :book, :consumer, :issued_at, presence: true

  before_save :set_due_date

  private

  def set_due_date
    self.due_date = self.issued_at
                        .advance(days: BttLibraryApp::DUE_DATE_PERIOD)
                        .to_date
  end

end
