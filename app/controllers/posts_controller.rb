# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: %i[show destroy]

  def index
    @posts = Post.all.order('created_at desc')
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = 'Saved...'
    else
      flash[:alert] = 'Something wrong...'
    end
    redirect_to posts_path
  end

  def show
    @images = @post.images
  end

  def destroy
    if @post.user == current_user
      if @post.destroy
        flash[:notice] = 'Post deleted!'
      else
        flash[:alert] = 'Something went wrong ...'
      end
    else
      flash[:alert] = "You don't have permission to do that!"
    end
    redirect_to root_path
  end

  private

  def find_post
    @post = Post.find_by id: params[:id]
    return if @post

    flash[:danger] = "Post doesn't exist!"
    redirect_to root_path
  end

  def post_params
    params.require(:post).permit(:content, images: [])
  end
end
