class CreatePermissionForProjects < ActiveRecord::Migration
  def change
    create_table :permission_for_projects do |t|
      t.integer :user_id
      t.integer :project_id

      t.timestamps
    end
  end
end
