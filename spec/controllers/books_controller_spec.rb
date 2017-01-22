require 'rails_helper'

RSpec.describe BooksController do

  let(:user) do
    create(:admin_user)
  end

  before do
    allow_any_instance_of(ApplicationController).to receive(:authenticate).and_return(true)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  describe 'GET#index' do
    before do
      @books = 2.times.map { create(:book) }
    end

    it 'reponds with success' do
      get :index

      expect(response).to have_http_status(200)
      assert_equal @books, assigns(:books)
    end
  end

end
