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
    true
  end

  def update?
    true
  end
end
