# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.new
user.firstname = 'brad'
user.lastname = 'pitt'
user.admin = true
user.email = 'brad@gmail.com'
user.password = 'valid_password'
user.password_confirmation = 'valid_password'
user.save!