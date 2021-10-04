# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { in: 3..50 }
  validates :bio, length: { maximum: 300 }

  has_one_attached :profile_pic
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy

  def like_on_post(post)
    likes.where(post_id: post.id)
  end
end
