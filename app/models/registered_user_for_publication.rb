class RegisteredUserForPublication < ActiveRecord::Base

  validates :unique_id, presence: true  
  validates :date_of_report, presence: true
  validates :device_uuid, presence: true, length: { maximum: 64 }  

end
