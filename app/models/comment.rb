# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  delegate :name, to: :user, prefix: true

  validates :content, presence: true
end
