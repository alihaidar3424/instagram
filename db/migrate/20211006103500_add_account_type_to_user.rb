# frozen_string_literal: true

class AddAccountTypeToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :account_type, :integer, default: 0
  end
end
