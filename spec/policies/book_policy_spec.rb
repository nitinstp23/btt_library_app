require 'rails_helper'

RSpec.describe BookPolicy do
  subject { described_class }

  before :all do
    @book     = create(:book)
    @admin    = create(:admin_user)
    @consumer = create(:consumer)
  end

  permissions :index? do
    it 'grants access if user is admin' do
      expect(subject).to permit(@admin, @book)
    end

    it 'grants access if user is consumer' do
      expect(subject).to permit(@consumer, @book)
    end
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

  permissions :show? do
    it 'grants access if user is admin' do
      expect(subject).to permit(@admin, @book)
    end

    it 'grants access if user is consumer' do
      expect(subject).to permit(@consumer, @book)
    end
  end

  permissions :edit? do
    it 'grants access if user is admin' do
      expect(subject).to permit(@admin, @book)
    end

    it 'denies access if user is not admin' do
      expect(subject).not_to permit(@consumer, @book)
    end
  end

  permissions :update? do
    it 'grants access if user is admin' do
      expect(subject).to permit(@admin, @book)
    end

    it 'denies access if user is not admin' do
      expect(subject).not_to permit(@consumer, @book)
    end
  end

  permissions :destroy? do
    it 'grants access if user is admin' do
      expect(subject).to permit(@admin, @book)
    end

    it 'denies access if user is not admin' do
      expect(subject).not_to permit(@consumer, @book)
    end
  end
end
