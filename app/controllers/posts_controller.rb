# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show destroy]

  def index
    @posts = Post.all.order('created_at desc')
    @post = Post.new
    authorize @posts
  end

  def create
    post = current_user.posts.build(post_params)
    authorize post
    if post.save
      flash[:notice] = 'Post Created!'
    else
      flash[:alert] = 'Something wrong...'
    end
    redirect_to posts_path
  end

  def show
    return if @post

    flash[:danger] = "Post doesn't exist!"
    redirect_to root_path
  end

  def destroy
    authorize @post
    if @post.destroy
      flash[:notice] = 'Post deleted!'
    else
      flash[:alert] = 'Something went wrong ...'
    end
    redirect_to root_path
  end

  def edit
    return if @post.user == current_user

    flash[:alert] = "You don't have permission to do that!"
    redirect_to post_path(@post)
  end

  def update
    post = Post.find_by id: params[:id]
    if post.user == current_user
      if post.update(post_params)
        flash[:notice] = 'Post updated!'
      else
        flash[:alert] = 'Something went wrong ...'
      end
    else
      flash[:alert] = "You don't have permission to do that!"
    end
    redirect_to post_path(post)
  end

  private

  def set_post
    @post = Post.find_by id: params[:id]
  end

  def post_params
    params.require(:post).permit(:content, images: [])
  end
end
