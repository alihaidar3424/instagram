# frozen_string_literal: true

class FollowershipService < ApplicationService
  attr_reader :user, :current_user

  def initialize(user, current_user)
    @user = user
    @current_user = current_user
  end

  def call
    follow = Follow.new(follower_id: current_user.id, following_id: user.id)
    follow.follow_status = :pending if user.account_type == 'secure'
    follow
  end
end
