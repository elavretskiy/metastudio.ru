class TagPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      @user.tags
    end
  end
end
