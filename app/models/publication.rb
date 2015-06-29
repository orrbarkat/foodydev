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
  validates :active_device_dev_uuid, presence: true, length: { maximum: 64 }

  before_validation :set_version
  before_save :default_values

  def set_version
    self.version = version.to_i + 1
  end

  def default_values
    self.is_on_air ||= true if self.is_on_air.nil?
  end

  def push
    require 'houston'
    @devices = ActiveDevice.where(is_ios: true).where.not(remote_notification_token: "no")
    certificate = File.read("/app/lib/assets/ck.pem")#/Users/orrbarkat/dev/foodydev/lib/assets/ck.pem")#ck_production/app
    passphrase = "g334613334613fxct"
    connection = Houston::Connection.new(Houston::APPLE_DEVELOPMENT_GATEWAY_URI, certificate, passphrase)
    connection.open
    @devices.each do |device|
      notification = Houston::Notification.new(device: 'fd01e0baab71ad02ffd4eb10e34daa06fbdb3352ce7286a20ef1333465bc494b')#device.remote_notification_token) #'
      notification.alert = "New event around you #{self.title}" 
      notification.badge = 1
      notification.sound = "default"
      notification.category = "ARRIVED_CATEGORY"
      notification.content_available = false
      notification.custom_data = {type:"new_publication",data:{ id:self.id,version:self.version,title:self.title}}
      connection.write(notification.message)
    end
    connection.close
  end
  handle_asynchronously :push

  def pushDelete
   require 'houston'
    @devices = ActiveDevice.where(is_ios: true).where.not(remote_notification_token: "no")
    certificate = File.read("/app/lib/assets/ck.pem")#ck_production
    passphrase = "g334613334613fxct"
    connection = Houston::Connection.new(Houston::APPLE_DEVELOPMENT_GATEWAY_URI, certificate, passphrase)
    connection.open
    @devices.each do |device|
      notification = Houston::Notification.new(device: device.remote_notification_token) #'fd01e0baab71ad02ffd4eb10e34daa06fbdb3352ce7286a20ef1333465bc494b'
      notification.alert = "Event finished around you #{self.title}" 
      notification.badge = 1
      notification.sound = "default"
      notification.category = "ARRIVED_CATEGORY"
      notification.content_available = false
      notification.custom_data = {type:"deleted_publication",data:{ id:self.id,version:self.version,title:self.title}}
      connection.write(notification.message)
    end
    connection.close
  end
  handle_asynchronously :pushDelete

end
