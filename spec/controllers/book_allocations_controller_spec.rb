require 'rails_helper'

RSpec.describe BookAllocationsController do

  let(:user) { create(:admin_user) }
  let(:book) { create(:book) }

  before do
    allow_any_instance_of(ApplicationController).to receive(:authenticate).and_return(true)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  describe 'GET#new' do
    before do
      get :new, params: { book_id: book.id }
    end

    it 'reponds with success' do
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template(:new)
    end
  end

  describe 'POST#create' do
    before do
      @consumer = create(:consumer)
    end

    context 'with valid attributes' do
      before do
        post :create,
          params: {
            book_id: book.id,
            book_allocation: {
              consumer_email: @consumer.email,
            }
          }
      end

      it 'responds with success' do
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(book_url(book))
        expect(flash[:notice]).to be_present
      end
    end

    context 'with invalid attributes' do
      before do
        post :create,
          params: {
            book_id: book.id,
            book_allocation: {
              consumer_email: 'invalid@email.com'
            }
          }
      end

      it 'renders new template' do
        expect(response).to have_http_status(200)
        expect(response).to render_template(:new)
      end
    end
  end

end
