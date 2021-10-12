# frozen_string_literal: true

class DeleteStory < ApplicationJob
  queue_as :default

  def perform
    # Do something
    Story.where(['created_at < ?', 1.minute.ago]).map(&:destroy)
  end
end
