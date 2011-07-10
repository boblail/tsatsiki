class AuthorizedProject < ActiveRecord::Base
  extend SettingsMachine
  
  belongs_to :user
  belongs_to :project
  
  has_settings :privileges, Privileges
  
  
  
  delegate :name,
           :to => :project
  
  
end
