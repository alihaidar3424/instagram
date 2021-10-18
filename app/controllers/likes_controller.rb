# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :set_like_and_post, only: :create

  def create
    authorize @post, policy_class: LikePolicy
    if @like.save
      respond_to :js
    else
      flash[:alert] = @like.errors.full_messages.join(', ')
      redirect_to(request.referer || root_path)
    end
  end

  def destroy
    @like = Like.find(params[:id])
    authorize @like
    @post = @like.post
    if @like.destroy
      respond_to :js
    else
      flash[:alert] = @like.errors.full_messages.join(', ')
      redirect_to(request.referer || root_path)
    end
  end

  private

  def set_like_and_post
    @like = current_user.likes.build(like_params)
    @post = @like.post
  end

  def like_params
    params.permit :post_id
  end
end
