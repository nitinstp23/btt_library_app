require 'rails_helper'

RSpec.describe Book do

  describe 'validations' do
    before do
      create(:book)
    end

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:author) }
    it { is_expected.to validate_presence_of(:isbn) }
    it { is_expected.to validate_numericality_of(:quantity).only_integer.is_greater_than(0) }
    it { is_expected.to validate_uniqueness_of(:isbn).ignoring_case_sensitivity }

    it { should have_many(:book_issues) }
  end

  describe 'callbacks' do
    describe 'before_save' do
      it 'upcases isbn' do
        isbn = '#isbn123'
        book = build(:book, isbn: isbn)

        book.save
        book.reload
        expect(book.isbn).to eq(isbn.upcase)
      end
    end
  end

  describe '#availability' do
    it 'returns available books count' do
      book = create(:book, quantity: 5)

      expect(book.availability).to eq(5)

      book.update(available_copies: 3)
      book.reload

      expect(book.availability).to eq(2)
    end
  end

end
