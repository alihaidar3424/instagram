# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[destroy edit update]

  def index
    @comments = @post.comments.includes(:user).order('created_at desc')
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
    @post = @comment.post
    if @comment.destroy
      respond_to :js
    else
      flash[:alert] = 'Something went wrong ...'
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      flash[:notice] = 'Comment updated!'
    else
      flash[:alert] = 'Something went wrong ...'
    end
    redirect_to post_path(@comment.post)
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
    authorize @comment
  end

  def comment_params
    params.required(:comment).permit :user_id, :post_id, :content
  end
end
