# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  def create
    super
    UserMailer.confirmation(resource).deliver unless resource.invalid?
  end

  protected

  def update_resource(resource, params)
    Rails.logger.debug params
    resource.update_without_password(params)
  end
end
