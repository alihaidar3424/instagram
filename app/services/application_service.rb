# frozen_string_literal: true

class ApplicationService
  def self.call(*args)
    new(*args).call
  end

  def self.find_posts(*args)
    new(*args).find_posts
  end
end
