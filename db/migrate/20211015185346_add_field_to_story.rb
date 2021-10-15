# frozen_string_literal: true

class AddFieldToStory < ActiveRecord::Migration[5.2]
  def change
    add_column :stories, :content, :string, limit: 255
  end
end
