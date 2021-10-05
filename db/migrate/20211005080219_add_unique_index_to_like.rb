# frozen_string_literal: true

class AddUniqueIndexToLike < ActiveRecord::Migration[5.2]
  def change
    remove_index :likes, :user_id
    remove_index :likes, :post_id
    add_index :likes, %i[user_id post_id], unique: true
  end
end
