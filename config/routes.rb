# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'books#info'
  resources :books, only: %i[index create]
  get '/books/query', to: 'books#query'
end
