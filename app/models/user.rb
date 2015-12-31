class User < ActiveRecord::Base
	  belongs_to :active_device


	  #validates :identity_provider_token, presence: true
      validates :phone_number, presence: true
      validates :identity_provider_email, presence: true
      validates :identity_provider_user_name, presence: true
      validates :active_device_dev_uuid, presence: true
end
