# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = User.find_by_identity_provider_email("foodonet@web.com")
unless user
	user = FactoryGirl.build(:user, identity_provider_email: "foodonet@web.com")
	user.identity_provider_user_name = 'WEB'
	user.save!
end