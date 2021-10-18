# frozen_string_literal: true

class AddValidationToPosts < ActiveRecord::Migration[5.2]
  def change
    change_column :posts, :content, :string, limit: 255
  end
end
