class ActiveDevice < ActiveRecord::Base
  has_many :publications, foreign_key: :active_device_dev_uuid, primary_key: :dev_uuid
  has_many :publication_reports
  has_many :feedbacks

  validates :remote_notification_token, presence: true, length: { maximum: 256 }
 # validates :is_ios, presence: true
  validates :last_location_latitude, presence: true
  validates :last_location_longitude, presence: true
  validates :dev_uuid, presence: true, length: { maximum: 64 }, uniqueness: true

  def is_android
  	(self!=nil && remote_notification_token!="no" && is_ios==false)
  end
  
  def is_iphone
  	(self!=nil && remote_notification_token!="no" && is_ios==true)
  end

  scope :today, -> {where("created_at<=? AND created_at>=?", Time.now, 1.day.ago)}
  scope :week, ->  {where("created_at<=? AND created_at>=?", Time.now, 1.week.ago)}
  scope :month, ->  {where("created_at<=? AND created_at>=?", Time.now, 1.month.ago)}

  scope :iphone, -> {where("is_ios=? AND remote_notification_token!=?", true, "no")}
  scope :android, -> {where("is_ios=? AND remote_notification_token!=?", false, "no")}
end
