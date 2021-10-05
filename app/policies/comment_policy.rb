# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def create?
    user.present?
  end

  def destroy?
    owner? || user == record.post.user
  end

  def edit?
    owner?
  end

  def update?
    owner?
  end
end
