require 'rails_helper'

RSpec.describe ApplicationController do
  let!(:admin_user) { create(:admin_user) }

  describe 'exception handling' do
    describe 'ActiveRecord::RecordNotFound' do
      controller do
        def index
          raise ActiveRecord::RecordNotFound
        end
      end

      it 'renders errors/not_found template' do
        get :index
        expect(response).to render_template('errors/not_found')
      end
    end

    describe 'Pundit::NotAuthorizedError' do
      controller do
        def index
          raise Pundit::NotAuthorizedError
        end
      end

      it 'renders errors/forbidden template' do
        get :index
        expect(response).to render_template('errors/forbidden')
      end
    end
  end

  describe '#authenticate' do
    controller do
      before_action :authenticate

      def index
        render plain: 'Authenticated'
      end
    end

    context 'with valid credentials' do
      it 'renders current template' do
        session[:user_id], session[:user_type] = admin_user.id, admin_user.class.to_s
        get :index

        expect(response).to have_http_status(200)
        expect(response.content_type).to eq('text/plain')
        expect(response.body).to eq('Authenticated')
      end
    end

    context 'with invalid credentials' do
      it 'redirects to new_session_url' do
        session[:user_id], session[:user_type] = nil, nil
        get :index

        expect(response).to have_http_status(302)
        expect(response).to redirect_to(new_session_url)
      end
    end

  end
end
