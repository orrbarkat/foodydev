class Publication < ActiveRecord::Base
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
  validates :is_on_air, presence: true
  validates :active_device_dev_uuid, presence: true, length: { maximum: 64 }

  before_validation :set_version

  def set_version
    self.version = version.to_i + 1
  end
end
