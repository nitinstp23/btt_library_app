require 'rails_helper'

RSpec.describe ApplicationHelper do

  describe '#navigation_link' do
    it 'returns the navigation link HTML tag' do
      helper.instance_variable_set(:@selected_nav, 'Books')

      expected_response = "<li class=\"active\"><a href=\"http://test.host/books\">Books</a></li>"

      expect(helper.navigation_link('Books', books_url)).to eq(expected_response)
    end
  end

  describe '#error_class_for' do
    context 'with validation error' do
      it 'returns the CSS class for error' do
        book = build(:book, title: '')
        book.save

        expect(helper.error_class_for(book, :title)).to eq('has-error')
      end
    end

    context 'with no validation errors' do
      it 'returns nil' do
        book = create(:book)

        expect(helper.error_class_for(book, :title)).to be_nil
      end
    end
  end

  describe '#error_messages_for' do
    context 'with validation error' do
      it 'returns error messages HTML' do
        book = build(:book, title: '')
        book.save

        expected_response = "<span class=\"help-inline text-danger\">can&#39;t be blank</span>"
        expect(helper.error_messages_for(book, :title)).to eq(expected_response)
      end
    end

    context 'with no validation errors' do
      it 'returns nil' do
        book = create(:book)

        expect(helper.error_messages_for(book, :title)).to be_nil
      end
    end
  end

end
