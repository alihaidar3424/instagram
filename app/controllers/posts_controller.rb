# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[show destroy edit update]
  before_action :authorization, only: %i[show destroy update]

  def index
    @posts = Post.of_current_and_followed_user(current_user).includes(:likes, :comments).order('created_at desc')
    @post = Post.new
  end

  def create
    post = current_user.posts.build(post_params)
    if post.save
      flash[:notice] = 'Post Created!'
    else
      flash[:alert] = post.errors.full_messages
    end
    redirect_to posts_path
  end

  def show
    @comment = Comment.new
  end

  def destroy
    if @post.destroy
      flash[:notice] = 'Post deleted!'
    else
      flash[:alert] = @post.errors.full_messages
    end
    redirect_to posts_path
  end

  def edit
    return @post if authorize @post

    redirect_to post_path(@post)
  end

  def update
    if @post.update(post_params)
      flash[:notice] = 'Post updated!'
    else
      flash[:alert] = @post.errors.full_messages
    end
    redirect_to post_path(@post)
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def authorization
    authorize @post
  end

  def post_params
    params.require(:post).permit(:content, images: [])
  end
end
