# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { 'Example Title' }
    author { 'Example Author' }
    genre { 'Example Genre' }
    publication_year { '2023' }
  end
end