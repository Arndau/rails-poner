class MessagePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.where(user: user)
    end
  end

  def show?
    true
  end

  def new?
    true
  end

  def destroy?
    record.user == user
  end

  def itinerary?
    record.message_users.where(user_id: user.id).exists?
  end
end
