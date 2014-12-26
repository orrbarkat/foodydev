class ActiveDevice < ActiveRecord::Base 

  belongs_to :publication_report

  validates :notification_token, presence: true, length: { maximum: 64 }
  validates :is_ios, presence: true
  validates :latitude, presence: true  
  validates :longitude, presence: true
  validates :dev_uuid, presence: true, length: { maximum: 64 }        

 
end
