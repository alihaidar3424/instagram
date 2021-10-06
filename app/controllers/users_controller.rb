# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @followed = current_user.followers.pluck(:id).include?(@user.id)
  end

  def follow_user
    # following_relationships.create(following_id: user_id)
    @followed = Follow.create(follower_id: params[:follow_id], following_id: current_user.id)
  end

  def unfollow_user
    # following_relationships.find_by!(following_id: user_id).destroy
    @followed = Follow.find_by!(follower_id: params[:follow_id], following_id: current_user.id).destroy
  end
end
