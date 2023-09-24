# frozen_string_literal: true

class RemovePublicationYearFromBooks < ActiveRecord::Migration[7.0]
  def change
    remove_column :books, :publication_year, :integer
  end
end
