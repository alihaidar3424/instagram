# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
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
    return true if user.present? && user == post.user
  end

  def show?
    true
  end

  private

  def post
    record
  end
end
