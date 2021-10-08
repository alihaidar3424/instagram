# frozen_string_literal: true

class Story < ApplicationRecord
  belongs_to :user
  has_many_attached :images

  validates :images, presence: true, length: {
    maximum: 10,
    message: "You can't select more than 10 images!"
  }

  delegate :name, to: :user, prefix: true

  scope :of_current_and_followed_user, lambda { |user|
                                         where user_id: [user, *user.following_relationships
                                                                    .followed.pluck('following_id')]
                                       }
end
