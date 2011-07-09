class PermissionForProject < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :project
  
  
  
  delegate :name,
           :to => :project
  
  
end
