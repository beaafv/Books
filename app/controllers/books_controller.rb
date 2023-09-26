# frozen_string_literal: true

class BooksController < ApplicationController
  def index
    if params[:query].present?
      query_string = "%#{params[:query]}%"
      @books = Book.where(
        'title ILIKE :query OR author ILIKE :query OR genre ILIKE :query', query: query_string
      )
    else
      @books = Book.all
    end
    render json: @books, status: :ok
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      render json: @book, status: :created
    else
      render json: { error: @book.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def info
    render json: {
      jsonapi: {
        version: '1.0'
      },
      meta: {
        description: 'API for team members to share books between each other',
        resources: {
          "books": "https://books-api-cloudwalk-9327532ccf14.herokuapp.com/books", # endpoint to fetch all books
          "adding a book": "https://books-api-cloudwalk-9327532ccf14.herokuapp.com/books", # endpoint to add a book via POST
        }
      },
      links: {
        self: "https://books-api-cloudwalk-9327532ccf14.herokuapp.com"
      }
    }
  end

  # strong params
  private

  def book_params
    params.require(:book).permit(:title, :author, :genre, :publication_year)
  end
end
