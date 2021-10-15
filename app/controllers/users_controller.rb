# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :force_json, only: :search
  # def index
  #   @users = User.ransack(params[:term]).result(distinct: true)
  #   respond_to :js
  # end

  def search
    @users = User.ransack(name_cont: params[:q]).result
  end

  def show
    @user = User.find(params[:id])
    @status = current_user.of_follow_user(@user, current_user) if @user != current_user
    @posts = @user.posts.includes(:likes, :comments) if @user == current_user || current_user
                                                        .of_followed_user(@user, current_user)
  end

  def requests_pending
    @users = User.pending_users(current_user)
  end

  private

  def force_json
    request.format = :json
  end
end
