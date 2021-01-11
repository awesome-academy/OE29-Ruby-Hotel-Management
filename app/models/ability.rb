class Ability
  include CanCan::Ability

  def initialize user
    alias_action :read, :update, to: :crud
    return if user.blank?

    if user.admin?
      can :crud, :reservation
      can :manage, :all
    else
      can :read, [:reservation, Room], Bill.ids do |id|
        user.bills.pluck(:id).include? id
      end
      can :manage, Rate
      can :create, :reservation
      can :create, [Comment, Bill]
      can :destroy, Comment, user_id: user.id
      can :read, Booking, bill: {user: {id: user.id}}
      can :crud, Bill, user: {id: user.id}
    end
  end
end
