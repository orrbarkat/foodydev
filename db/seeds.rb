# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = User.find_or_initialize_by(identity_provider_email: "foodonet@web.com")
user.update_attributes!(identity_provider_user_name: 'WEB',
						identity_provider: "facebook",
					    identity_provider_user_id: "facebookuseridkeyisverylong",
					    identity_provider_token: "facebooktokenkey",
					    phone_number: "123456789",
					    is_logged_in: true,
					    active_device_dev_uuid: "justOnethatdoesnotexist",
					    ratings: nil)