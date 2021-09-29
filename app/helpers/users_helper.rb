# frozen_string_literal: true

module UsersHelper
  def avatar_url(user)
    return user.profile_pic if user.profile_pic.attached?

    'default.png'
  end
end
