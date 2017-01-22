require 'rails_helper'

RSpec.describe Session do

  it { is_expected.to validate_presence_of(:email) }
  it { should allow_value('test@email.com').for(:email) }
  it { is_expected.to validate_presence_of(:password) }

  let!(:admin_user) do
    create(:admin_user, email: 'test@email.com', password: 'password')
  end

  describe 'custom validations' do
    describe 'user_authenticity' do
      context 'with valid credentials' do
        it 'passes' do
          session = described_class.new(email: admin_user.email, password: admin_user.password, is_admin: true)

          expect(session.valid?).to eq(true)
        end
      end

      context 'with invalid credentials' do
        it 'fails' do
          session = described_class.new(email: admin_user.email, password: 'wrong password', is_admin: true)
          session.valid?

          expect(session.errors[:base].first).to eq('Invalid Email or Password')
        end
      end
    end
  end

  describe '#initialize' do
    it 'set instance variables' do
      session = described_class.new(email: admin_user.email, password: admin_user.password, is_admin: true)

      expect(session.instance_variable_get(:@email)).to eq(admin_user.email)
      expect(session.instance_variable_get(:@password)).to eq(admin_user.password)
      expect(session.instance_variable_get(:@is_admin)).to eq(true)
    end
  end

  describe '#user_id' do
    context 'for admin user' do
      context 'with valid details' do
        it 'returns user id' do
          session = described_class.new(email: admin_user.email, password: admin_user.password, is_admin: true)

          expect(session.user_id).to eq(admin_user.id)
        end
      end

      context 'with invalid details' do
        it 'returns nil' do
          session  = described_class.new(email: 'invalid@email.com', password: 'password', is_admin: true)

          expect(session.user_id).to be_nil
        end
      end
    end

    context 'for consumer' do
      context 'with valid details' do
        it 'returns user id' do
          consumer = create(:consumer, email: 'test@email.com', password: 'password')
          session  = described_class.new(email: consumer.email, password: consumer.password, is_admin: false)

          expect(session.user_id).to eq(consumer.id)
        end
      end

      context 'with invalid details' do
        it 'returns nil' do
          consumer = create(:consumer, email: 'test@email.com', password: 'password')
          session  = described_class.new(email: 'invalid@email.com', password: 'password', is_admin: false)

          expect(session.user_id).to be_nil
        end
      end
    end
  end

  describe '#user_type' do
    context 'for admin user' do
      context 'with valid details' do
        it 'returns admin_user class name' do
          session = described_class.new(email: admin_user.email, password: admin_user.password, is_admin: true)

          expect(session.user_type).to eq(admin_user.class.to_s)
        end
      end

      context 'with invalid details' do
        it 'returns NullUser class name' do
          session = described_class.new(email: 'invalid@email.com', password: 'password', is_admin: true)

          expect(session.user_type).to eq('NullUser')
        end
      end
    end

    context 'for consumer' do
      context 'with valid details' do
        it 'returns consumer class name' do
          consumer = create(:consumer, email: 'test@email.com', password: 'password')
          session  = described_class.new(email: consumer.email, password: consumer.password, is_admin: false)

          expect(session.user_type).to eq(consumer.class.to_s)
        end
      end

      context 'with invalid details' do
        it 'returns NullUser class name' do
          consumer = create(:consumer, email: 'test@email.com', password: 'password')
          session  = described_class.new(email: 'invalid@email.com', password: 'password', is_admin: false)

          expect(session.user_type).to eq('NullUser')
        end
      end
    end
  end
end
