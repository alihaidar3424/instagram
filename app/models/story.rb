# frozen_string_literal: true

class Story < ApplicationRecord
  include Scopeable
  belongs_to :user
  has_many_attached :images

  validates :images, presence: true, length: {
    maximum: 10,
    message: "You can't select more than 10 images!"
  }

  validates :content, length: { maximum: 255 }

  delegate :name, to: :user, prefix: true
end
