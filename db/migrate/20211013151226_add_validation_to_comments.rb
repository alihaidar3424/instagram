# frozen_string_literal: true

class AddValidationToComments < ActiveRecord::Migration[5.2]
  def change
    change_column :comments, :content, :string, limit: 255
  end
end
