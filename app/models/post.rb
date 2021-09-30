# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :images

  validates :images, presence: true
  delegate :name, to: :user, prefix: true

  def belongs_to?(user)
    Post.find_by(user_id: user.id, id: id)
  end
end
