# frozen_string_literal: true

class Follow < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :following, class_name: 'User'

  enum follow_status: { followed: 0, pending: 1 }
  validates :follower_id, uniqueness: { scope: :following_id }
end
