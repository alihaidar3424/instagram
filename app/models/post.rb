# frozen_string_literal: true

class Post < ApplicationRecord
  include Scopeable
  belongs_to :user
  has_many_attached :images
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :images, presence: true, length: {
    maximum: 10,
    message: "You can't select more than 10 images!"
  },
                     blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..(5.megabytes) }

  validates :content, length: { maximum: 255 }

  delegate :name, to: :user, prefix: true
  delegate :profile_pic, to: :user, prefix: true
end
