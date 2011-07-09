# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

user = User.create({
  :username => "admin",
  :password => "password",
  :password_confirmation => "password",
  :email => "admin@example.com"
})

project = Project.create({
  :user_id => user.id,
  :path => Rails.root.to_s,
  :name => "Tsatsiki"
})

puts "",
     "===================================================================",
     "Welcome to Tsatsiki",
     "",
     "An account was created with the following information:",
     "   Email: #{user.email}",
     "   Username: #{user.username}",
     "   Password: #{user.password}",
     "",
     "==================================================================="
