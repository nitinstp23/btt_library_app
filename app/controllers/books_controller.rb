class BooksController < ApplicationController
  before_action :authenticate

  def index
    @books = Book.page(params[:page])
  end

end
