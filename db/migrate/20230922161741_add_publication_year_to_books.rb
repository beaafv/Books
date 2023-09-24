# frozen_string_literal: true

class AddPublicationYearToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :publication_year, :date
  end
end
