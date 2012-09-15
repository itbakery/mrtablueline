# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'SETTING UP DEFAULT USER LOGIN'
user1 = User.create! :name => 'sawangpong', :email => 'sawangpongm@gmail.com', :password => '1q2w3e4r@q!', :password_confirmation => '1q2w3e4r@q!', :confirmed_at => DateTime.now
puts 'New user created: ' << user1.name
user2 = User.create! :name => 'wirun', :email => 'wirunt@gmail.com', :password => '1234abcd', :password_confirmation => '1234abcd', :confirmed_at => DateTime.now
puts 'New user created: ' << user2.name
user3 = User.create! :name => 'somchai', :email => 'test1@example.com', :password => '1234abcd', :password_confirmation => '1234abcd', :confirmed_at => DateTime.now
puts 'New user created: ' << user3.name
user1.add_role :admin
user2.add_role :admin
user3.add_role :author
