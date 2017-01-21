require 'rails_helper'

RSpec.describe Book do

  describe 'validations' do
    before do
      create(:book)
    end

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:author) }
    it { is_expected.to validate_presence_of(:isbn) }
    it { is_expected.to validate_numericality_of(:quantity).only_integer }
    it { is_expected.to validate_uniqueness_of(:isbn).ignoring_case_sensitivity }
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

end
