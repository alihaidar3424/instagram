# frozen_string_literal: true

class LikePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    owner? || follower?
  end

  def destroy?
    owner?
  end
end
