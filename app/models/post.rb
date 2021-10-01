# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :images

  validates :images, length: {
    maximum: 10,
    message: "You can't select more than 10 images!"
  }
  delegate :name, to: :user, prefix: true
  delegate :profile_pic, to: :user, prefix: true

  def belongs_to?(user)
    Post.find_by(user_id: user.id, id: id)
  end
end
