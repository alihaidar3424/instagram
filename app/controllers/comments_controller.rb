# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit destroy update]
  before_action :authorize_comment, only: %i[edit destroy update]
  before_action :create_comment, only: :create
  before_action :set_post, only: %i[create destroy]

  def create
    authorize @post, policy_class: CommentPolicy
    if @comment.save
      respond_to :js
    else
      flash[:alert] = @comment.errors.full_messages.join(', ')
      redirect_to(request.referer || root_path)
    end
  end

  def destroy
    if @comment.destroy
      respond_to :js
    else
      flash[:alert] = @comment.errors.full_messages.join(', ')
      redirect_to(request.referer || root_path)
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      flash[:notice] = 'Comment updated!'
    else
      flash[:alert] = @comment.errors.full_messages.join(', ')
    end
    redirect_to post_path(@comment.post)
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def authorize_comment
    authorize @comment
  end

  def create_comment
    @comment = current_user.comments.build(comment_params)
  end

  def set_post
    @post = @comment.post
  end

  def comment_params
    params.require(:comment).permit :post_id, :content
  end
end
