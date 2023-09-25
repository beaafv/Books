# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Books', type: :request do
  describe 'GET /books' do
    context 'if there are books on the database' do
      it ' should display all books' do
        create(:book)
        get '/books'
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).not_to be_empty
      end
    end
    context 'if the database is empty' do
      it 'shouldnt return any books' do
        # simulating a get request
        get '/books'
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq([])
      end
    end
  end

  # tests to add a book
  describe 'POST /books' do
    context 'if the user submits a book' do
      it 'should add a book to the list' do
        book_params = {
          title: 'New Book Title',
          author: 'New Book Author',
          genre: 'New Book Genre',
          publication_year: '2024-01-10'
        }
        # simulating a post request
        post '/books', params: { book: book_params }
        create(:book)
        expect(response).to have_http_status(:created)
      end
    end
  end
  describe 'GET/books/query' do
    context 'query by title' do
      it 'returns a book that matches book title' do
        book1 = create(:book, title: 'example 1')
        book2 = create(:book, title: 'example2')
        # simulating a get request with title
        get '/books/query', params: { query: 'example 1' }
        expect(response).to have_http_status(:ok)
        expect(response.body).to include(book1.to_json)
        expect(response.body).not_to include(book2.to_json)
        expect(JSON.parse(response.body)).not_to eq([])

      end
    end

    context 'query by author' do
      it 'returns a book that matches book author' do
        book1 = create(:book, title: 'example', author: 'author 1')
        book2 = create(:book, title: ' example1', author: 'author 2')
        # simulating a get request with author
        get '/books/query', params: { query: 'author 1' }
        expect(response).to have_http_status(:ok)
        expect(response.body).to include(book1.to_json)
        expect(response.body).not_to include(book2.to_json)
      end
    end
    context 'query by genre' do
      it 'returns a book that matches book title' do
        book1 = create(:book, title: 'example2', genre: 'genre 1')
        book2 = create(:book, title: 'example3', genre: 'genre 2')
        # simulating a get request with genre
        get '/books/query', params: { query: 'genre 1' }
        expect(response).to have_http_status(:ok)
        expect(response.body).to include(book1.to_json)
        expect(response.body).not_to include(book2.to_json)
      end
    end
    context 'query by publication_year' do
      it 'returns a book that matches book publication year' do
        book1 = create(:book, title: 'example4', publication_year: '2023-08-10')
        book2 = create(:book, title: 'example5', publication_year: '2023-06-10')
        # simulating a get request with publication year

        get '/books/query', params: { query: '2023-08-10' }
        expect(response).to have_http_status(:ok)
        expect(response.body).to include(book1.to_json)
        expect(response.body).not_to include(book2.to_json)
      end
    end
    # if the query doesnt match any book
    context 'when no books match the query' do
      it 'returns an empty list' do
        create(:book, title: 'example6')
        create(:book, title: 'example7')
        get '/books/query', params: { query: 'not a book' }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq([])
      end
    end
  end
end
