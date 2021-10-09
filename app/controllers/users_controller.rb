# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.search(params[:term])
    respond_to :js
  end

  def show
    @user = User.find(params[:id])
    @status = UserService.call(@user, current_user)
    @posts = UserService.find_posts(@user, current_user)
  end

  def requests_pending
    @users = User.pending_users(current_user)
  end
end
