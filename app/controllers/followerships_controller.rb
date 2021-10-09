# frozen_string_literal: true

class FollowershipsController < ApplicationController
  def create
    @user = User.find(params[:follow_id])
    follow = FollowershipService.call(@user, current_user)
    if follow.save
      respond_to :js
    else
      flash[:alert] = 'Something went wrong ...'
    end
  end

  def destroy
    @user = Follow.find_by!(follower_id: current_user.id, following_id: params[:follow_id])
    if @user.destroy
      respond_to :js
    else
      flash[:alert] = 'Something went wrong ...'
    end
  end

  def update
    @user = Follow.find_by!(follower_id: params[:follow_id], following_id: current_user.id)
    if @user.update(follow_status: :followed)
      respond_to :js
    else
      flash[:alert] = 'Something went wrong ...'
    end
  end
end
