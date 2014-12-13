class ActiveDevice < ActiveRecord::Base 

  validates :notification_token, presence: true, length: { maximum: 64 }
  validates :is_ios, presence: true
  validates :latitude, presence: true  
  validates :longitude, presence: true
  validates :device_uuid, presence: true, length: { maximum: 64 }        

  before_validation :set_version

  def set_version
    self.version = version.to_i + 1
  end
end
