class PublicationReport < ActiveRecord::Base

  validates :unique_id, presence: true
  validates :version, presence: true
  validates :report, presence: true  
  validates :date_of_report, presence: true
  validates :device_uuid, presence: true, length: { maximum: 64 }        

  before_validation :set_version
  before_save :init_data
  
   def set_version
    self.version = version.to_i + 1
   end	


  def init_data
    self.date_of_report ||= Date.today if new_record?
  end
end
