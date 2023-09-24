# frozen_string_literal: true

class BooksController < ApplicationController
  def index
    @books = Book.all
    render json: @books, status: :ok
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.create(book_params)
    if @book.save
      render json: @book, status: :created
    else
      render :new, status: 422
    end
  end

  def query
    query_string = "%#{params[:query]}%"
    @books = Book.where(
      'title ILIKE :query OR author ILIKE :query OR genre ILIKE :query OR publication_year::text ILIKE :query', query: query_string
      )
    render json: @books, status: :ok
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :genre, :publication_year)
  end
end
