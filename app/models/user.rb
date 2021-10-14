# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { in: 3..50 }
  validates :bio, length: { maximum: 255 }

  has_one_attached :profile_pic
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :stories, dependent: :destroy

  has_many :follower_relationships, foreign_key: :following_id, class_name: 'Follow',
                                    dependent: :nullify
  has_many :followers, through: :follower_relationships, source: :follower

  has_many :following_relationships, foreign_key: :follower_id, class_name: 'Follow',
                                     dependent: :nullify
  has_many :following, through: :following_relationships, source: :following

  enum account_type: { general: 0, secure: 1 }

  scope :pending_users, ->(user) { where id: user.follower_relationships.pending.pluck('follower_id') }
  scope :followed_users, ->(user) { where id: user.follower_relationships.followed.pluck('follower_id') }
  scope :following_users, lambda { |user1, user2|
                            where id: user1.following_relationships.followed
                                           .pluck('following_id').include?(user2.id)
                          }
  scope :search, ->(term) { where('lower(name) LIKE ?', "%#{term.downcase}%") if term }

  def like_on_post(post)
    likes.where(post_id: post.id)
  end
end
