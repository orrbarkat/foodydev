class ActiveDevice < ActiveRecord::Base
  has_many :publications, foreign_key: :active_device_dev_uuid, primary_key: :dev_uuid
  has_many :publication_reports

  validates :remote_notification_token, presence: true, length: { maximum: 152 }
  validates :is_ios, presence: true
  validates :last_location_latitude, presence: true
  validates :last_location_longitude, presence: true
  validates :dev_uuid, presence: true, length: { maximum: 152 }, uniqueness: true
end
