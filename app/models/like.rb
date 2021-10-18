# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :user_id, uniqueness: { scope: :post_id }

  scope :by_user, ->(user) { where(user_id: user.id) }
end
