class Ability
  include CanCan::Ability

  def initialize user
    alias_action :read, :update, to: :crud
    return if user.blank?

    if user.admin?
      can :crud, :reservation
      can :manage, :all
    else
      can :read, [:reservation, Room]
      can :manage, Rate
      can :create, [Comment, Bill]
      can :destroy, Comment, user: {id: user.id}
      can :read, Booking, bill: {user: {id: user.id}}
      can :crud, Bill, user: {id: user.id}
    end
  end
end
