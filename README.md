# README
# Book Recomendations API
This is a simple API for managing and querying book recommendations. 
Team members can use this API to add books to a shared list and search for books based on specific parameters.

## Prerequisites

- Ruby 3.1
- Ruby on Rails 7.0
- PostgreSQL

## Getting started
- Clone this repository 
- navigate to the repository
- install gems - bundle install
- setup the DB: rails db:create rails db:migrate
- open the server: rails server

## HTTP status codes and their meanings:

- 200 OK: The request was successful.
- 422 unprocessable_entity: The request was well-formed but was unable to be followed due to semantic errors.
- 400 Bad Request: The request is malformed or invalid.
- 401 Unauthorized: Authentication is required or has failed.
- 403 Forbidden: The client does not have permission to access the resource.
- 404 Not Found: The requested resource could not be found.
- 500 Internal Server Error: An unexpected server error occurred.


## ENDPOINTS:
- GET /books: Retrieve a list of all books.
- POST /books: Add a new book to the database.
- GET /books/query: Search for books based on specific parameters (title, author, genre, publication year).

## Book Entry
A book entry should include the following attributes:

- title (string): The title of the book. The title must be unique.
- author (string): The author of the book.
- genre (string): The genre of the book.
- publication_year (date): The publication year of the book.

## Book Query
You can query books using the /books/query endpoint by providing a search string for the query parameter.
The API will search for books that match the title, author, genre, or publication year based on the provided query string.

## Running Tests
To run all the tests, navigate to the project root and execute the following: 
- $ rspec

