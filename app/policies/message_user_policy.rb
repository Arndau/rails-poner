class MessageUserPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.where(user: user)
    end
  end

  def access_to_message?
    true
  end

  def update?
  true
  end
end
