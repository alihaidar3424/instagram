# frozen_string_literal: true

class LikesController < ApplicationController
  def create
    @like = current_user.likes.build(like_params)
    @post = @like.post
    authorize @post, policy_class: LikePolicy
    if @like.save
      respond_to :js
    else
      flash[:alert] = @like.errors.full_messages
    end
  end

  def destroy
    @like = Like.find(params[:id])
    authorize @like
    @post = @like.post
    if @like.destroy
      respond_to :js
    else
      flash[:alert] = @like.errors.full_messages
    end
  end

  private

  def like_params
    params.permit :post_id
  end
end
