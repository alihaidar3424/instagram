# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit destroy update]
  before_action :authorization, only: %i[edit destroy update]

  def create
    comment = current_user.comments.build(comment_params)
    @post = comment.post
    authorize @post, policy_class: CommentPolicy
    if comment.save
      respond_to :js
    else
      flash[:alert] = comment.errors.full_messages
    end
  end

  def destroy
    @post = @comment.post
    if @comment.destroy
      respond_to :js
    else
      flash[:alert] = @comment.errors.full_messages
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      flash[:notice] = 'Comment updated!'
    else
      flash[:alert] = @comment.errors.full_messages
    end
    redirect_to post_path(@comment.post)
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def authorization
    authorize @comment
  end

  def comment_params
    params.require(:comment).permit :post_id, :content
  end
end
