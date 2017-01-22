require 'rails_helper'

RSpec.describe NullUser do

  let(:null_user) { described_class.new }

  describe '#id' do
    it 'return nil' do
      expect(null_user.id).to be_nil
    end
  end

  describe '#authenticate' do
    it 'return false' do
      expect(null_user.authenticate()).to be_falsey
    end
  end

  describe '#present?' do
    it 'return false' do
      expect(null_user.present?).to be_falsey
    end
  end

end
