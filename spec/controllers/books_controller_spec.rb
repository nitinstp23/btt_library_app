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

  describe 'GET#new' do
    before do
      get :new
    end

    it 'reponds with success' do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST#create' do
    context 'with valid attributes' do
      before do
        post :create,
          params: {
            book: {
              title: 'Harry Potter',
              author: 'JK Rowling',
              isbn: '#337AB7',
              quantity: 10,
            }
          }
      end

      it 'responds with success' do
        expect(response).to have_http_status(302)
      end

      it 'creates a book' do
        book = Book.find_by(title: 'Harry Potter')

        expect(response).to redirect_to(book_url(book))
        expect(flash[:notice]).to be_present
      end
    end

    context 'with invalid attributes' do
      before do
        post :create,
          params: {
            book: {
              title: 'Harry Potter'
            }
          }
      end

      it 'renders new template' do
        expect(response).to have_http_status(200)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET#show' do
    before do
      @book = create(:book)

      get :show, params: { id: @book.id }
    end

    it 'responds with success' do
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
      assert_equal @book, assigns(:book)
    end
  end

  describe 'GET#edit' do
    before do
      @book = create(:book)

      get :edit, params: { id: @book.id }
    end

    it 'responds with success' do
      expect(response).to have_http_status(200)
      expect(response).to render_template(:edit)
      assert_equal @book, assigns(:book)
    end
  end

  describe 'PUT#update' do
    before do
      book = create(:book)

      put :update,
        params: {
          id: book.id,
          book: {
            title: 'The Life of Pi'
          }
        }
    end

    it 'response with success' do
      expect(response).to have_http_status(302)
    end

    it 'updates book' do
      book = Book.find_by(title: 'The Life of Pi')

      expect(response).to redirect_to(book_url(book))
      expect(flash[:notice]).to be_present
    end
  end

  describe 'DELETE#destroy' do
    before do
      @book = create(:book)

      delete :destroy, params: { id: @book.id}
    end

    it 'deletes book' do
      expect { @book.reload }.to raise_error(ActiveRecord::RecordNotFound)
      expect(response).to redirect_to(books_url)
      expect(flash[:notice]).to be_present
    end
  end

end
