class PublicationReport < ActiveRecord::Base

  has_one :publication
  has_one :active_device

  validates :publication_id, presence: true
  validates :publication_version, presence: true
  validates :report, presence: true  
  validates :date_of_report, presence: true
  validates :active_device_dev_uuid, presence: true, length: { maximum: 64 }        

  before_validation :set_version
  before_create :set_default_report_data
  
   def set_version
    self.version = version.to_i + 1
   end	


  def set_default_report_data
    self.date_of_report ||= Date.today
  end
end
