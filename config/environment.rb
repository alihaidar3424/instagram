# frozen_string_literal: true

# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = :smtp
ActionMailer::Base.smtp_settings = {
  address: 'smtp.gmail.com',
  port: 465,
  user_name: ENV['EMAIL_USER_NAME'],
  password: ENV['EMAIL_PASSWORD'],
  authentication: 'plain',
  ssl: true,
  tsl: true,
  enable_starttls_auto: true
}
