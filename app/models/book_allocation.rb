class BookAllocation
  include ActiveModel::Model

  attr_accessor :book_id, :consumer_email

  validates :book_id, :consumer_email, presence: true
  validate  :valid_consumer?
  validate  :duplicate_allocation

  def initialize(attrs = {})
    @book_id        = attrs[:book_id]
    @consumer_email = attrs[:consumer_email]
  end

  def create
    return unless self.valid?

    consumer.book_issues.create(book_id: book_id, issued_at: DateTime.current)
    Book.increment_counter(:available_copies, 1)

    true
  end

  private

  def consumer
    @consumer ||= Consumer.where(email: consumer_email).first
  end

  def consumer_exists?
    !!consumer
  end

  def valid_consumer?
    return if consumer_exists?

    self.errors.add(:consumer_email, I18n.t('book.allocations.invalid_user'))
  end

  def duplicate_allocation
    return unless consumer_exists?
    return if !consumer.book_issues.where(book_id: book_id).exists?

    self.errors.add(:base, I18n.t('book.allocations.duplicate'))
  end
end
