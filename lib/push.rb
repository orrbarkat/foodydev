def push(publication)
  @devices = ActiveDevice.where(is_ios: true).where.not(remote_notification_token: "no")
  certificate = File.read("/app/lib/assets/cd_production_new.pem")#ck_production
  passphrase = "fdprod77457745" #"g334613334613fxct"  
  connection = Houston::Connection.new(Houston::APPLE_PRODUCTION_GATEWAY_URI, certificate, passphrase)
  
  @devices.each do |device|
    connection.open
    notification = Houston::Notification.new(device: device.remote_notification_token ) #8ca9c4f8cf26da318f144695c7568d32bc23460dae806469b20bfa4ff33c4241')
    notification.alert = "New event around you #{publication.title}" 
    notification.badge = 1
    notification.sound = "default"
    notification.category = "ARRIVED_CATEGORY"
    notification.content_available = false
    notification.custom_data = {type:"new_publication",data:{ id:publication.id,version:publication.version,title:publication.title}}
    connection.write(notification.message)
    connection.close
  end
  
end
  
def pushDelete(publication)
  @registered = RegisteredUserForPublication.where("publication_id = ? AND publication_version = ?" , publication.id , publication.version)
#  @devices = @registered.where(is_ios: true).where.not(remote_notification_token: "no")
  certificate = File.read("/app/lib/assets/cd_production_new.pem")#ck_production
  passphrase = "fdprod77457745" #"g334613334613fxct"
  connection = Houston::Connection.new(Houston::APPLE_PRODUCTION_GATEWAY_URI, certificate, passphrase)

 # @devices.each do |device|
  @registered.each do |registration|
    device =  ActiveDevice.find_by dev_uuid: registration.active_device_dev_uuid
    unless device == nil or device.remote_notification_token == "no"
    
      connection.open
      notification = Houston::Notification.new(device: device.remote_notification_token) #8ca9c4f8cf26da318f144695c7568d32bc23460dae806469b20bfa4ff33c4241 
      notification.alert = "Event finished around you #{publication.title}" 
      notification.badge = 1
      notification.sound = "default"
      notification.category = "ARRIVED_CATEGORY"
      notification.content_available = true
      notification.custom_data = {type:"deleted_publication",data:{ id:publication.id,version:publication.version,title:publication.title}}
      connection.write(notification.message)
      connection.close
    end
  end  
end

def pushRegistered_User(publication, registration)
  device =  ActiveDevice.find_by dev_uuid: publication.active_device_dev_uuid #ActiveDevice.where(dev_uuid: publication.active_device_dev_uuid).where.not(remote_notification_token: "no")
  unless device == nil or device.remote_notification_token == "no"
    certificate = File.read("/app/lib/assets/cd_production_new.pem")#ck_production
    passphrase = "fdprod77457745" #"g334613334613fxct"  
    connection = Houston::Connection.new(Houston::APPLE_PRODUCTION_GATEWAY_URI, certificate, passphrase)
    
    connection.open
    notification = Houston::Notification.new(device: device.remote_notification_token ) #8ca9c4f8cf26da318f144695c7568d32bc23460dae806469b20bfa4ff33c4241')
    notification.alert = "User comes to pick up #{publication.title}"
    notification.badge = 1
    notification.sound = "default"
    notification.category = "ARRIVED_CATEGORY"
    notification.content_available = false
    notification.custom_data = {type:"regisration_for_publication",data:{ id:publication.id,version:publication.version,date:registration.date_of_registration}}
    connection.write(notification.message)
    connection.close
  end
end
