# frozen_string_literal: true

class StoryRemoverWorker
  include Sidekiq::Worker

  def perform
    # Do something
    Story.where(['created_at < ?', 1.minute.ago]).map(&:destroy)
  end
end

Sidekiq::Cron::Job.create(name: 'Worker - every 5 minutes', cron: '*/5 * * * *', class: 'StoryRemoverWorker')
# execute at every 5 minutes, ex: 12:05, 12:10, 12:15...etc
