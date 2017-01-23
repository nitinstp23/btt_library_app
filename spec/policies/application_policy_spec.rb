require 'rails_helper'

RSpec.describe ApplicationPolicy do

  subject { described_class }

  before :all do
    @user   = create(:admin_user)
    @record = create(:book)
  end

  context '#initialize' do
    it 'initialize variable with values' do
      builder = subject.new(@user, @record)

      expect(builder.instance_variable_get(:@user)).to eq(@user)
      expect(builder.instance_variable_get(:@record)).to eq(@record)
      expect(builder.instance_variable_get(:@is_admin)).to eq(true)
      expect(builder.instance_variable_get(:@is_consumer)).to eq(false)
    end
  end

  permissions :index? do
    it 'denies access for index' do
      expect(subject).not_to permit(@user, @record)
    end
  end

  permissions :show? do
    it 'denies access if record not exists' do
      record2 = create(:book)
      record2.delete

      expect(subject).not_to permit(@user, record2)
    end

    it 'allow access if record exists' do
      record2 = create(:book)

      expect(subject).to permit(@user, record2)
    end
  end

  permissions :create? do
    it 'denies access for create?' do
      expect(subject).not_to permit(@user, @record)
    end
  end

  permissions :new? do
    it 'denies access for new?' do
      expect(subject).not_to permit(@user, @record)
    end
  end

  permissions :edit? do
    it 'denies access for edit?' do
      expect(subject).not_to permit(@user, @record)
    end
  end

  permissions :destroy? do
    it 'denies access for destroy?' do
      expect(subject).not_to permit(@user, @record)
    end
  end

  permissions :update? do
    it 'denies access for update?' do
      expect(subject).not_to permit(@user, @record)
    end
  end
end
