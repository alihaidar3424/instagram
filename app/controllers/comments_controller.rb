# frozen_string_literal: true
class CommentsController < ApplicationController
  def index
    @comments = @post.comments.includes(:user)
  end

  def create
    comment = current_user.comments.build(comment_params)
    @post = comment.post
    if comment.save
      respond_to :js
    else
      flash[:alert] = 'Something went wrong ...'
    end
  end

  def destroy
    @comment = Comment.find_by id: params[:id]
    authorize @comment
    @post = @comment.post
    if @comment.destroy
      respond_to :js
    else
      flash[:alert] = 'Something went wrong ...'
    end
  end

  private

  def comment_params
    params.required(:comment).permit :user_id, :post_id, :content
  end
end
