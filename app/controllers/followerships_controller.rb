# frozen_string_literal: true

class FollowershipsController < ApplicationController
  def create
    @user = User.find(params[:follow_id])
    # follow = Follow.new(follower_id: current_user.id, following_id: @user.id)
    # follow.follow_status = :pending if @user.secure?
    follow = FollowershipService.call(@user, current_user)
    if follow.save
      redirect_to(request.referer || root_path)
    else
      flash[:alert] = follow.errors.full_messages
    end
  end

  def destroy
    follow = Follow.find_by!(follower_id: current_user.id, following_id: params[:follow_id])
    if follow.destroy
      redirect_to(request.referer || root_path)
    else
      flash[:alert] = @follow.errors.full_messages
    end
  end

  def update
    @follow = Follow.find_by!(follower_id: params[:follow_id], following_id: current_user.id)
    if @follow.update(follow_status: :followed)
      flash[:notice] = 'Follow Request Accepted'
      redirect_to(request.referer || root_path)
    else
      flash[:alert] = @follow.errors.full_messages
    end
  end

  def reject
    @follow = Follow.find_by!(follower_id: params[:follow_id], following_id: current_user.id)
    if @follow.destroy
      flash[:alert] = 'Follow Request Rejected'
      redirect_to(request.referer || root_path)
    else
      flash[:alert] = @follow.errors.full_messages
    end
  end
end
