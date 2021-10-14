# frozen_string_literal: true

class AddValidationToUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :website, :string, limit: 255
  end
end
