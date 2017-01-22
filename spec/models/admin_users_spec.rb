require 'rails_helper'

RSpec.describe AdminUser do

  describe 'validations' do
    before do
      create(:admin_user)
    end

    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { should allow_value('test@email.com').for(:email) }
    it { is_expected.to validate_length_of(:password).is_at_least(8) }
  end

end
