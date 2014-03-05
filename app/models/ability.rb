class Ability
  include CanCan::Ability

  def initialize(user)
    # User registered
    if user.present?
      can :manage, Cookbook, user_id: user.id
      can :manage, Recipe, user_id: user.id
    end
  end
end
