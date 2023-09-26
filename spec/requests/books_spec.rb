# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Books', type: :request do
  let(:parsed_response) {JSON.parse(response.body)}
  describe 'GET /books' do
    context 'if there are books on the database' do
      it ' should display all books' do
        create(:book)
        get '/books'
        expect(response).to have_http_status(:ok)
        expect(parsed_response).not_to be_empty
      end
    end
    context 'when the database is empty' do
      it 'returns an empty array' do
        get '/books'
        expect(response).to have_http_status(:ok)
        expect(parsed_response).to eq([])
      end
    end

    context 'query by title' do
      it 'returns a book that matches book title' do
        book1 = create(:book, title: 'example 1')
        book2 = create(:book, title: 'example2')
        get '/books', params: { query: 'example 1' }
        expect(response).to have_http_status(:ok)
        expect(response.body).to include(book1.to_json)
        expect(response.body).not_to include(book2.to_json)
        expect(parsed_response).not_to eq([])

      end
    end

    context 'query by author' do
      it 'returns a book that matches book author' do
        book1 = create(:book, title: 'example', author: 'author 1')
        book2 = create(:book, title: ' example1', author: 'author 2')
        get '/books', params: { query: 'author 1' }
        expect(response).to have_http_status(:ok)
        expect(response.body).to include(book1.to_json)
        expect(response.body).not_to include(book2.to_json)
      end
    end
    context 'query by genre' do
      it 'returns a book that matches book genre' do
        book1 = create(:book, title: 'example2', genre: 'genre 1')
        book2 = create(:book, title: 'example3', genre: 'genre 2')
        # simulating a get request with genre
        get '/books', params: { query: 'genre 1' }
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
        get '/books', params: { query: 'not a book' }
        expect(response).to have_http_status(:ok)
        expect(parsed_response).to eq([])
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
        expect { post '/books', params: { book: book_params } }.to change(Book, :count).by(1)
        expect(response).to have_http_status(:created)
        expect(parsed_response['title']).to eq('New Book Title')
        expect(parsed_response['author']).to eq('New Book Author')
        expect(parsed_response['genre']).to eq('New Book Genre')
        expect(parsed_response['publication_year']).to eq('2024-01-10')
      end
    end
    context 'when title is missing' do
      it 'returns an error' do
        book_params = {
          # title: 'New Book Title',
          author: 'New Book Author',
          genre: 'New Book Genre',
          publication_year: '2024-01-10'
        }
        post '/books', params: { book: book_params }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(parsed_response['error']).to include("Title can't be blank")
      end
    end
    context 'when author is missing' do
      it 'returns an error' do
        book_params = {
          title: 'New Book Title example 1',
          # author: 'New Book Author',
          genre: 'New Book Genre',
          publication_year: '2024-01-10'
        }
        post '/books', params: { book: book_params }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(parsed_response['error']).to include("Author can't be blank")
      end
    end
    context 'when genre is missing' do
      it 'returns an error' do
        book_params = {
          title: 'New Book Title example 12',
          author: 'New Book Author',
          # genre: 'New Book Genre',
          publication_year: '2024-01-10'
        }
        post '/books', params: { book: book_params }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(parsed_response['error']).to include("Genre can't be blank")
      end
    end
    context 'when publication date is missing' do
      it 'returns an error' do
        book_params = {
          title: 'New Book Title example 123',
          author: 'New Book Author',
          genre: 'New Book Genre',
          # publication_year: '2024-01-10'
        }
        post '/books', params: { book: book_params }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(parsed_response['error']).to include("Publication year can't be blank")
      end
    end
  end
end
