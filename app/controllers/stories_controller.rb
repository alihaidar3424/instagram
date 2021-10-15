# frozen_string_literal: true

class StoriesController < ApplicationController
  before_action :set_story, only: %i[show destroy]
  before_action :authorize_story, only: %i[show destroy]

  def index
    @stories = Story.of_current_and_followed_user(current_user).order('created_at desc')
    @story = Story.new
  end

  def create
    story = current_user.stories.build(story_params)
    if story.save
      flash[:notice] = 'Story Created!'
    else
      flash[:alert] = story.errors.full_messages
    end
    redirect_to stories_path
  end

  def destroy
    if @story.destroy
      flash[:notice] = 'Story deleted!'
    else
      flash[:alert] = @story.errors.full_messages
    end
    redirect_to stories_path
  end

  def show; end

  private

  def set_story
    @story = Story.find(params[:id])
  end

  def authorize_story
    authorize @story
  end

  def story_params
    params.require(:story).permit(images: [])
  end
end
