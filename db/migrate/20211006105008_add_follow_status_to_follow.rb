# frozen_string_literal: true

class AddFollowStatusToFollow < ActiveRecord::Migration[5.2]
  def change
    add_column :follows, :follow_status, :integer, default: 0
  end
end
