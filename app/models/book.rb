# frozen_string_literal: true

class Book < ApplicationRecord
  validates :title, :genre, :publication_year, :author, presence: true
  # Book title should be unique
  validates :title, uniqueness: true
end
