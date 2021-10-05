# frozen_string_literal: true

class AddValidationsOnComments < ActiveRecord::Migration[5.2]
  def change
    change_column_null(:comments, :content, false)
  end
end
