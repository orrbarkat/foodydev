

def push(publication)
  @devices = ActiveDevice.where(is_ios: true).where.not(remote_notification_token: "no")
  certificate = File.read("/app/lib/assets/ck_foodonet_dev.pem")#ck_production
  passphrase = "g334613f@@@"#"g334613334613fxct"  
  connection = Houston::Connection.new(Houston::APPLE_DEVELOPMENT_GATEWAY_URI, certificate, passphrase)
  connection.open
  @devices.each do |device|  
    notification = Houston::Notification.new(device: "909cb3d2629c81fd703e35a026d025b1f325e6174b4cb5955aa18dcbe87c3cbf")
    notification.alert = "New event around you #{publication.title}" 
    notification.badge = 1
    notification.sound = "default"
    notification.category = "ARRIVED_CATEGORY"
    notification.content_available = true
    notification.custom_data = {type:"new_publication",data:{ id:publication.id,version:publication.version,title:publication.title}}
    connection.write(notification.message)
  end
  connection.close
end
  
def pushDelete(publication)
  require '/app/lib/gcm_dev.rb'
  pushGcmDelete(publication)
  #@registered = RegisteredUserForPublication.where("publication_id = ? AND publication_version = ?" , publication.id , publication.version)
  #@devices = @registered.where(is_ios: true).where.not(remote_notification_token: "no")
  registered = iphone_tokens(publication)
  certificate = File.read("/app/lib/assets/ck_foodonet_dev.pem")#ck_production
  passphrase = "g334613f@@@"#"g334613334613fxct"
  connection = Houston::Connection.new(Houston::APPLE_DEVELOPMENT_GATEWAY_URI, certificate, passphrase)
  connection.open
  registered.each do |token|
    notification = Houston::Notification.new(device: "909cb3d2629c81fd703e35a026d025b1f325e6174b4cb5955aa18dcbe87c3cbf")
    notification.alert = "Event finished around you #{publication.title}" 
    notification.badge = 1
    notification.sound = "default"
    notification.category = "ARRIVED_CATEGORY"
    notification.content_available = true
    notification.custom_data = {type:"deleted_publication",data:{ id:publication.id,version:publication.version,title:publication.title}}
    connection.write(notification.message)
  end        
  connection.close
end

def pushRegistered(publication)
  
  registered = iphone_tokens(publication)

  certificate = File.read("/app/lib/assets/ck_foodonet_dev.pem")#ck_production
  passphrase = "g334613f@@@"#"g334613334613fxct"(Houston::APPLE_PRODUCTION_GATEWAY_URI, certificate, passphrase)
  connection = Houston::Connection.new(Houston::APPLE_DEVELOPMENT_GATEWAY_URI, certificate, passphrase)
  connection.open
  registered.each do |token|
    notification = Houston::Notification.new(device: "909cb3d2629c81fd703e35a026d025b1f325e6174b4cb5955aa18dcbe87c3cbf")
    notification.alert = "User comes to pick up #{publication.title}"
    notification.badge = 1
    notification.sound = "default"
    notification.category = "ARRIVED_CATEGORY"
    notification.content_available = true
    notification.custom_data = {type:"registration_for_publication",data:{ id:publication.id,version:publication.version,date:registration.date_of_registration}}
    connection.write(notification.message)
  end   
  connection.close
end

def pushReport(publication, report)
  #@registered = RegisteredUserForPublication.where("publication_id = ? AND publication_version = ?" , publication.id , publication.version)
  #@devices = @registered.where(is_ios: true).where.not(remote_notification_token: "no")
  registered = iphone_tokens(publication)

  certificate = File.read("/app/lib/assets/ck_foodonet_dev.pem")#ck_production
  passphrase = "g334613f@@@"#"g334613334613fxct"(Houston::APPLE_PRODUCTION_GATEWAY_URI, certificate, passphrase)
  connection = Houston::Connection.new(Houston::APPLE_DEVELOPMENT_GATEWAY_URI, certificate, passphrase)
  connection.open
  registered.each do |token|
    notification = Houston::Notification.new(device: "909cb3d2629c81fd703e35a026d025b1f325e6174b4cb5955aa18dcbe87c3cbf")
    notification.alert = 'New report'
    notification.badge = 1
    notification.sound = "default"
    notification.category = 'ARRIVED_CATEGORY'
    notification.content_available = true
    notification.custom_data = {type:"publication_report",data:{:publication_id=>publication.id,:publication_version=>publication.version,:date_of_report=>report.date_of_report, :report=>report.report}}
    connection.write(notification.message)
  end       
  connection.close
end

# def pushReport_owner(publication)
#   device =  ActiveDevice.find_by dev_uuid: publication.active_device_dev_uuid #ActiveDevice.where(dev_uuid: publication.active_device_dev_uuid).where.not(remote_notification_token: "no")
#   unless device == nil or device.remote_notification_token == "no"
#     certificate = File.read("/app/lib/assets/ck_foodonet_dev.pem")#ck_production
#     passphrase = "g334613f@@@"#"g334613334613fxct" 
#     connection = Houston::Connection.new(Houston::APPLE_DEVELOPMENT_GATEWAY_URI, certificate, passphrase)
  
#     connection.open
#     notification = Houston::Notification.new(device: "909cb3d2629c81fd703e35a026d025b1f325e6174b4cb5955aa18dcbe87c3cbf")
#     notification.alert = 'New report'
#     notification.badge = 1
#     notification.sound = "default"
#     notification.category = 'ARRIVED_CATEGORY'
#     notification.content_available = true
#     notification.custom_data = {type:"publication_report",data:{ id:publication.id,version:publication.version,date:publication.starting_date,report_message:"#{publication.title} לע שדח חוויד"}}
#     connection.write(notification.message)
#     connection.close
#   end
# end

def iphone_tokens(publication)
  registered = publication.registered_user_for_publication
  i=0
  tokens = []
  registered.each do |r|
    if r.is_real && r.is_ios
      tokens [i] = r.token
      i=i+1
    end
  end
  owner = ActiveDevice.find_by dev_uuid: publication.active_device_dev_uuid
  if owner.is_iphone
    tokens<<owner.remote_notification_token
  end
  return tokens
end

