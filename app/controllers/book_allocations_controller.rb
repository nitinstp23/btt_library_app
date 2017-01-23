class BookAllocationsController < ApplicationController
  before_action :authenticate

  def new
    @book            = Book.find(params[:book_id])
    @book_allocation = BookAllocation.new

    authorize @book_allocation
  end

  def create
    @book            = Book.find(params[:book_id])
    @book_allocation = BookAllocation.new(book_id: @book.id,
                                          consumer_email: book_allocation_params[:consumer_email])

    authorize @book_allocation

    if @book_allocation.create
      redirect_to book_url(@book), notice: 'Book allocation successful'
    else
      render :new
    end
  end

  private

  def book_allocation_params
    params.require(:book_allocation).permit(:consumer_email)
  end
end
