require 'rails_helper'

RSpec.describe BookIssue do

  describe 'validations' do
    before do
      create(:book_issue)
    end

    it { is_expected.to validate_presence_of(:book) }
    it { is_expected.to validate_presence_of(:consumer) }
    it { is_expected.to validate_presence_of(:issued_at) }

    it { should belong_to(:book) }
    it { should belong_to(:consumer) }
  end

  describe 'callbacks' do
    describe 'before_save' do
      it 'sets due_date' do
        current_time = Date.today.to_datetime
        book_issue   = build(:book_issue, issued_at: current_time)

        book_issue.save
        book_issue.reload

        Timecop.freeze(current_time + BttLibraryApp::DUE_DATE_PERIOD) do
          expect(book_issue.due_date).to eq(Date.today)
        end
      end
    end
  end

end
