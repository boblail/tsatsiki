class AuthorizedProject
  class Privileges < SettingsMachine::Base
    
    has_fields :project,
               :features
    
    alias_method :for_project, :project
    alias_method :for_project=, :project=
    
    alias_method :for_features, :features
    alias_method :for_features=, :features=
    
  end
end