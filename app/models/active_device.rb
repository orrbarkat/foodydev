class ActiveDevice < ActiveRecord::Base 

  validates :notification_token, presence: true, length: { maximum: 64 }
  validates :is_ios, presence: true
  validates :latitude, presence: true  
  validates :longitude, presence: true
  validates :device_uuid, presence: true, length: { maximum: 64 }        

 
end
