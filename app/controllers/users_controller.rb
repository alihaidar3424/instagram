# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.search(params[:term])
    respond_to :js
  end

  def show
    @user = User.find(params[:id])
    if current_user.following_relationships.find_by(following_id: @user.id)
      @status = current_user.following_relationships.find_by!(following_id: @user.id).follow_status
    end
    @posts = @user.posts.includes(:likes, :comments)
  end

  def requests_pending
    @users = User.pending_users(current_user)
  end
end
