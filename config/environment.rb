# frozen_string_literal: true

# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.raise_delivery_errors = false
ActionMailer::Base.perform_caching = false
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  user_name: Rails.application.credentials.email_user_name,
  password: Rails.application.credentials.email_password,
  domain: Rails.application.credentials.domain,
  address: Rails.application.credentials.address,
  port: 587,
  authentication: :plain,
  enable_starttls_auto: true
}
