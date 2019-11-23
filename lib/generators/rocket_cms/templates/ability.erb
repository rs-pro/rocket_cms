class Ability
  include CanCan::Ability

  def initialize(user)
    unless user.nil?
      can :read, :all
      can :manage, :all
      cannot :destroy, Menu
      cannot :update, Menu
      if RocketCMS.active_record?
        cannot :destroy, PaperTrail::Version
        cannot :update, PaperTrail::Version
      end
      admin_ui
    end
  end

  def admin_ui
    can :access, :rails_admin
    can :read, :dashboard
  end
end
