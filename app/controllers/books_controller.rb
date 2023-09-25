# frozen_string_literal: true

class BooksController < ApplicationController
  def index
    @books = Book.all
    # convert ruby object into json format as the body of the HTTP
    render json: @books, status: :ok
  end

  def create
    @book = Book.create(book_params)
    if @book.save
      render json: @book, status: :created
    else
      render json: {error: @book.errors.full_messages }, status: 422
    end
  end

  def query
    query_string = "%#{params[:query]}%"
    # case insensitive
    @books = Book.where(
      'title ILIKE :query OR author ILIKE :query OR genre ILIKE :query OR publication_year::text ILIKE :query', query: query_string
    )
    render json: @books, status: :ok
  end

  # strong params
  private
  def book_params
    params.require(:book).permit(:title, :author, :genre, :publication_year)
  end
end
