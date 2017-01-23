class BooksController < ApplicationController
  before_action :authenticate

  def index
    @books = Book.page(params[:page])
    authorize @books
  end

  def new
    @book = Book.new
    authorize @book
  end

  def create
    @book = Book.new(book_params)
    authorize @book

    if @book.save
      redirect_to book_url(@book), notice: 'New Book Created'
    else
      render :new
    end
  end

  def show
    @book = Book.find(params[:id])
    authorize @book
  end

  def edit
    @book = Book.find(params[:id])
    authorize @book
  end

  def update
    @book = Book.find(params[:id])
    authorize @book

    if @book.update(book_params)
      redirect_to book_url(@book), notice: 'Book Updated'
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    authorize book

    book.destroy
    redirect_to books_url, notice: 'Book Deleted'
  end

  private

  def book_params
    params.require(:book).permit(:title,
                                 :author,
                                 :isbn,
                                 :quantity)
  end
end
