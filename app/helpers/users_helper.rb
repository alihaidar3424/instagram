# frozen_string_literal: true

module UsersHelper
  def avatar_url(_user)
    # return _user.image.gsub!('_normal', '') if user.image
    'default.png'
  end
end
