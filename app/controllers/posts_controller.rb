# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[show destroy edit update]

  def index
    @posts = Post.all.includes(:likes).order('created_at desc')
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
    if @post
      @liked = @post.liked?(current_user)
      return
    end

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
    redirect_to posts_path
  end

  def edit
    return @post if authorize @post

    redirect_to post_path(@post)
  end

  def update
    authorize @post
    if @post.update(post_params)
      flash[:notice] = 'Post updated!'
    else
      flash[:alert] = 'Something went wrong ...'
    end
    redirect_to post_path(@post)
  end

  private

  def set_post
    @post = Post.find_by id: params[:id]
  end

  def post_params
    params.require(:post).permit(:content, images: [])
  end
end
