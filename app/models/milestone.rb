class Milestone < ActiveRecord::Base
  
  belongs_to :project
  
  validates_presence_of :name, :version
  validates_uniqueness_of :version, :scope => :project_id
  
end
