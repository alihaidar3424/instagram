# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'ali.haidar@devsinc.com'
  layout 'mailer'
end
