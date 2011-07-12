class AuthorizedProject
  class Privileges < SettingsMachine::Base
    
    has_fields :project,
               :features
    
    
    def project
      read_privilege_for(:project)
    end
    alias :for_project :project
    alias :for_project= :project=
    
    
    def features
      read_privilege_for(:features)
    end
    alias :for_features :features
    alias :for_features= :features=
    
    
  private
    
    
    VALID_PERMISSIONS = %w{read create update destroy manage}
    
    def read_privilege_for(field)
      privilege = self[field].to_s
      privilege = "read" unless VALID_PERMISSIONS.member?(privilege)
      privilege.to_sym
    end
    
    
  end
end