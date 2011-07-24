class Project < ActiveRecord::Base
  
  
  
  belongs_to :user
  has_many :authorized_users, :class_name => "AuthorizedProject"
  
  
  
  validates_presence_of :user_id
  
  
  
  after_create :give_owner_admin_privileges
  
  
  
  def path_to_features
    File.join(self.path, 'features')
  end
  
  def features
    @features ||= Feature.get_features(self, self.path_to_features)
  end
  
  def scenarios
    @scenarios ||= features.inject([]) {|all, feature| all.concat(feature.all_scenarios)}
  end
  
  def find_feature(relative_path)
    find_feature_in_array(features, relative_path)
  end
  
  
  
  def execute_javascript_scenarios?
    true
  end
  
  def uses_bundler?
    @uses_bundler ||= File.exists?(File.join(self.path, "Gemfile"))
  end
  
  
  
private
  
  
  
  def give_owner_admin_privileges
    authorized_user = authorized_users.build(:user => user, :project => self)
    authorized_user.privileges.for_project = :manage
    authorized_user.save!
  end
  
  
  
  def find_feature_in_array(features, relative_path)
    features.each do |feature|
      return feature if feature.relative_path == relative_path
      subfeature = find_feature_in_array(feature.features, relative_path)
      return subfeature if subfeature
    end
    nil
  end
  
  
  
end
