# frozen_string_literal: true

class FollowershipsController < ApplicationController
  before_action :set_following, only: %i[update reject]
  before_action :set_follow_status, only: :create
  before_action :set_follower, only: :destroy

  def create
    if @follow.save
      flash[:notice] = 'Follow User'
    else
      flash[:alert] = @follow.errors.full_messages.join(', ')
    end
    redirect_to(request.referer || root_path)
  end

  def destroy
    if @follow.destroy
      flash[:notice] = 'Unfollow User'
    else
      flash[:alert] = @follow.errors.full_messages.join(', ')
    end
    redirect_to(request.referer || root_path)
  end

  def update
    if @follow.update(follow_status: :followed)
      flash[:notice] = 'Follow Request Accepted'
    else
      flash[:alert] = @follow.errors.full_messages.join(', ')
    end
    redirect_to(request.referer || root_path)
  end

  def reject
    if @follow.destroy
      flash[:notice] = 'Follow Request Rejected'
    else
      flash[:alert] = @follow.errors.full_messages(', ')
    end
    redirect_to(request.referer || root_path)
  end

  private

  def set_following
    @follow = Follow.find_by!(follower_id: params[:follow_id], following_id: current_user.id)
  end

  def set_follower
    @follow = Follow.find_by!(follower_id: current_user.id, following_id: params[:follow_id])
  end

  def set_follow_status
    @user = User.find(params[:follow_id])
    @follow = Follow.new(follower_id: current_user.id, following_id: @user.id)
    @follow.follow_status = :pending if @user.secure?
  end
end
