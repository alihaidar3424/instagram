# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def confirmation(user)
    @user = user
    mail(to: user.email, subject: 'Registered', from: ENV['EMAIL_USER_NAME'])
  end
end
