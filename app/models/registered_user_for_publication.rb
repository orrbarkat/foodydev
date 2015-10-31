class RegisteredUserForPublication < ActiveRecord::Base

  belongs_to 	:publication
  
  validates :publication_id, presence: true  
  validates :active_device_dev_uuid, presence: true, length: { maximum: 64 }
  validates :date_of_registration, presence: true  
  validates :publication_version, presence:true 
  validates :collector_contact_info, presence: true, length: { maximum: 100 }
  validates :collector_name, presence: true, length: { maximum: 100 }

  
  
  def token
  ActiveDevice.find_by_dev_uuid(active_device_dev_uuid).remote_notification_token
  end

  def is_real
    device = ActiveDevice.find_by_dev_uuid(active_device_dev_uuid)
    (device !=nil) && (device.remote_notification_token != "no")
  end

  def is_ios
    ActiveDevice.find_by_dev_uuid(active_device_dev_uuid).is_ios
  end

end
