# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def destroy?
    owner?
  end

  def edit?
    owner?
  end

  def update?
    owner?
  end

  def show?
    owner? || follower?
  end
end
