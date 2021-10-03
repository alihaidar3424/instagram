# frozen_string_literal: true

class LikesController < ApplicationController
  def create
    @like = current_user.likes.build(like_params)
    @post = @like.post
    if @like.save
      respond_to :js
    else
      flash[:alert] = 'Something went wrong ...'
    end
  end

  def destroy
    @like = Like.find_by id: params[:id]
    @post = @like.post
    if @like.destroy
      respond_to :js
    else
      flash[:alert] = 'Something went wrong ...'
    end
  end

  private

  def like_params
    params.permit :post_id
  end
end
