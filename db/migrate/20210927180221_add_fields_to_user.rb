# frozen_string_literal: true

class AddFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    change_table :users, bulk: true do |t|
      t.string :website
      t.text :bio, limit: 300
    end
  end
end
