class Publication < ActiveRecord::Base
  @@WEB_USER_ID = User.find_by_identity_provider_email("foodonet@web.com").id

  belongs_to :active_device
  has_many :publication_report
  has_many :registered_user_for_publication, foreign_key: :publication_id, primary_key: :id

  validates :version, presence: true
  validates :title, presence: true, length: { maximum: 200 }
  validates :address, presence: true, length: { maximum: 100 }
  validates :type_of_collecting, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :starting_date, presence: true
  validates :ending_date, presence: true
  validates :contact_info, presence: true, length: { maximum: 100 }
  validates :active_device_dev_uuid, presence: true, length: { maximum: 64 }

  before_validation :set_version, :set_user_name
 
  before_save :default_values

  def set_version
    self.version = version.to_i + 1
  end

  def default_values
    self.is_on_air ||= true if self.is_on_air.nil?
    self.audience = 0 if self.audience.nil?
  end

  def set_user_name
    user = self.publisher_id.nil? ? User.find(@@WEB_USER_ID) : User.find(self.publisher_id)
    self.identity_provider_user_name = user.identity_provider_user_name unless user.nil?
  end

end
