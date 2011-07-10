class CreateAuthorizedProjects < ActiveRecord::Migration
  def change
    create_table :authorized_projects do |t|
      t.integer :user_id
      t.integer :project_id
      t.text    :privileges
      
      t.timestamps
    end
  end
end
