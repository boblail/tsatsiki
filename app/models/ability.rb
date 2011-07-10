class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
    
    # All users (including Guests) can see everything
    can :read, :all
    
    if user && user.admin?
      
      # The superuser can manage everything
      can :manage, :all
      
    elsif user
      
      # General users abilities depend on AuthorizedProject records
      user.authorized_projects.each do |authorized_project|
        privilege = authorized_project.privileges
        project_id = authorized_project.project_id
        
        can privilege.for_project,  Project,  :id => project_id
        can privilege.for_features, Feature,  :project_id => project_id
        can privilege.for_features, Scenario, :project_id => project_id
      end
    end
    
  end
end
