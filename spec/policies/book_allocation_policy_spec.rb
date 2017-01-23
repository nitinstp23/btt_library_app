require 'rails_helper'

RSpec.describe BookAllocationPolicy do
  subject { described_class }

  before :all do
    @book     = create(:book)
    @admin    = create(:admin_user)
    @consumer = create(:consumer)
  end

  permissions :new? do
    it 'grants access if user is admin' do
      expect(subject).to permit(@admin, @book)
    end

    it 'denies access if user is not admin' do
      expect(subject).not_to permit(@consumer, @book)
    end
  end

  permissions :create? do
    it 'grants access if user is admin' do
      expect(subject).to permit(@admin, @book)
    end

    it 'denies access if user is not admin' do
      expect(subject).not_to permit(@consumer, @book)
    end
  end

end
