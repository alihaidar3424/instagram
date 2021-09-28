# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  protected

  def update_resource(resource, params)
    Rails.logger.debug params
    resource.update_without_password(params)
  end
end
