namespace :foodonet do
	task web_user: :environment do
		user = User.find_or_initialize_by(id: 1)
		user.update_attributes!(identity_provider_user_name: 'WEB',
						identity_provider_email: "web@foodonet.com",
						identity_provider: "facebook",
					    identity_provider_user_id: "facebookuseridkeyisverylong",
					    identity_provider_token: "facebooktokenkey",
					    phone_number: "123456789",
					    is_logged_in: true,
					    active_device_dev_uuid: "justOnethatdoesnotexist",
					    ratings: nil)
		user.save!
	end
end