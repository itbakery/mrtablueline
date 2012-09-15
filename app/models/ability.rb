class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.has_role? :admin
      can :manage, :all
    else
      can :read,  :all
      if user.has_role? :supervisor
        can :create,:all
        can :update,:all
      end
      if user.has_role? :mrtaadmin
        can :create, :all
        can :update, :all
        can :mrta, :all
      end
      if user.has_role? :author
        can :create, :all
        can :update, Report do |r|
          r.try(:user) == user
        end
        can :destroy, Report do |r|
          r.try(:user) == user
        end
        can :update, Announce do |a|
          a.try(:user) == user
        end
        can :destroy, Announce do |a|
          a.try(:user) == user
        end
        can :update, Page do |p|
          p.try(:user) == user
        end
         can :destroy, Page do |p|
          p.try(:user) == user
        end
        can :update, Announce do |a|
          a.try(:user) == user
        end
        can :destroy, Announce do |a|
          a.try(:user) == user
        end

      end
    end
  end
end
