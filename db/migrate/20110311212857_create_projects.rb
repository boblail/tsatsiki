class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.integer :user_id, :null => false
      
      t.string :name, :null => false
      t.string :path, :null => false
      
      t.timestamps
    end
  end
  
  def self.down
    drop_table :projects
  end
end
