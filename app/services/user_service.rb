# frozen_string_literal: true

class UserService < ApplicationService
  attr_reader :user, :current_user

  def initialize(user, current_user)
    @user = user
    @current_user = current_user
  end

  def call
    user_query = @current_user.following_relationships.find_by(following_id: @user.id)
    return user_query.follow_status if user_query
  end

  def find_posts
    if user == current_user
      user.posts.includes(:likes, :comments)
    elsif current_user.following_relationships.followed.pluck('following_id').include?(user.id)
      user.posts.includes(:likes, :comments)
    else
      []
    end
  end
end
