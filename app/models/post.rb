# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :images, presence: true, length: {
    maximum: 10,
    message: "You can't select more than 10 images!"
  }
  delegate :name, to: :user, prefix: true
  delegate :profile_pic, to: :user, prefix: true
end
