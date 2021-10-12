# frozen_string_literal: true

schedule_file = 'config/schedule.yml'
Sidekiq::Queue.all.each(&:clear)
Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file) if File.exist?(schedule_file) && Sidekiq.server?
