require 'rails_helper'

RSpec.describe SessionsController do

  let(:user) do
    create(:admin_user)
  end

  describe 'GET#new' do
    it 'responds with success' do
      get :new

      expect(response).to have_http_status(200)
      expect(response).to render_template(:new)
    end
  end

  describe 'POST#create' do
    context 'with valid credentials' do
      before do
        post :create,
          params: {
            session: {
              email: user.email,
              password: user.password,
              is_admin: true
            }
          }
      end

      it 'creates the session' do
        expect(session[:user_id]).to eq(user.id)
        expect(session[:user_type]).to eq(user.class.to_s)

        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_url)
        expect(flash[:notice]).to be_present
      end
    end

    context 'with invalid credentials' do
      before do
        post :create,
          params: {
            session: {
              email: user.email,
              password: 'wrong password',
              is_admin: true
            }
          }
      end

      it 'renders login template' do
        expect(response).to have_http_status(200)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'get#logout' do
    it 'clears user session' do
      allow_any_instance_of(ApplicationController).to receive(:authenticate).and_return(true)
      get :logout

      expect(session[:user_id]).to be_nil
      expect(session[:user_type]).to be_nil

      expect(response).to have_http_status(302)
      expect(response).to redirect_to(new_session_url)
    end
  end

end
