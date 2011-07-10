require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  
  def setup
    @user = User.create({
      :username => "admin",
      :password => "password",
      :password_confirmation => "password",
      :email => "admin@example.com"
    })
  end
  
  test "when a project is created, the creator gets admin privileges" do
    project = Project.new({
      :user_id => @user.id,
      :path => Rails.root.to_s,
      :name => "Tsatsiki"
    })
    
    assert_difference 'AuthorizedProject.count', +1 do
      project.save!
    end
    
    assert_equal :manage, @user.authorized_projects.first.privileges.for_project
    
    ability = Ability.new(@user)
    assert ability.can?(:manage, project)
  end
  
  
  
end
