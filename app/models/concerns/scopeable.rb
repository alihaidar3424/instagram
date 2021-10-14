# frozen_string_literal: true

module Scopeable
  extend ActiveSupport::Concern
  included do
    scope :of_current_and_followed_user, lambda { |user|
      where user_id: [user, *user.following_relationships
                                 .followed.pluck('following_id')]
    }
  end
end
