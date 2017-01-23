require 'rails_helper'

RSpec.describe BookAllocation do

  describe 'validations' do
    it { is_expected.to validate_presence_of(:book_id) }
    it { is_expected.to validate_presence_of(:consumer_email) }

    describe 'custom validations' do
      describe '#valid_consumer?' do
        before do
          @book     = create(:book)
          @consumer = create(:consumer)
        end

        context 'with valid consumer_email' do
          it 'passes' do
            book_allocation = described_class.new(book_id: @book.id, consumer_email: @consumer.email)
            book_allocation.valid?

            expect(book_allocation.errors[:consumer_email].first).to be_nil
          end
        end

        context 'with invalid consumer_email' do
          it 'fails' do
            book_allocation = described_class.new(book_id: @book.id, consumer_email: 'invalid@email.com')
            book_allocation.valid?

            expect(book_allocation.errors[:consumer_email].first).to eq(I18n.t('book.allocations.invalid_user'))
          end
        end
      end

      describe '#duplicate_allocation' do
        before do
          @book     = create(:book)
          @consumer = create(:consumer)
        end

        context 'without duplicate book allocations' do
          it 'passes' do
            book_allocation = described_class.new(book_id: @book.id, consumer_email: @consumer.email)
            book_allocation.valid?

            expect(book_allocation.errors[:base].first).to be_nil
          end
        end

        context 'with duplicate book allocations' do
          it 'fails' do
            create(:book_issue, book: @book, consumer: @consumer)

            book_allocation = described_class.new(book_id: @book.id, consumer_email: @consumer.email)
            book_allocation.valid?

            expect(book_allocation.errors[:base].first).to eq(I18n.t('book.allocations.duplicate'))
          end
        end
      end
    end
  end

  describe '#create' do
    before do
      @book     = create(:book)
      @consumer = create(:consumer)
    end

    context 'with valid attributes' do
      it 'creates book issue' do
        book_allocation = described_class.new(book_id: @book.id, consumer_email: @consumer.email)

        expect(@consumer.book_issues.where(book_id: @book.id).count).to eq(0)

        expect(book_allocation.create).to be_truthy

        expect(@consumer.book_issues.where(book_id: @book.id).count).to eq(1)
      end
    end

    context 'with invalid attributes' do
      it 'does not creates book issue' do
        book_allocation = described_class.new(book_id: @book.id, consumer_email: 'invalid@email.com')

        expect(@consumer.book_issues.where(book_id: @book.id).count).to eq(0)

        expect(book_allocation.create).to be_nil

        expect(@consumer.book_issues.where(book_id: @book.id).count).to eq(0)
      end
    end
  end

end
