# frozen_string_literal: true

class Book < ApplicationRecord
  validates :title, :genre, :publication_year, :author, presence: true
  validates :title, uniqueness: true
end
