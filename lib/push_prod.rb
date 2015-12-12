

def push(publication)
  @devices = ActiveDevice.where(is_ios: true).where.not(remote_notification_token: "no")
  certificate = File.read(ENV["certificate_path"])#ck_production
  connection = Houston::Connection.new(Houston::APPLE_PRODUCTION_GATEWAY_URI, certificate, ENV["password"])
  connection.open
  @devices.each do |device|  
    notification = Houston::Notification.new(device: device.remote_notification_token)
    notification.alert = "New event around you #{publication.title}" 
    # notification.badge = 1
    notification.sound = "default"
    notification.category = "ARRIVED_CATEGORY"
    notification.content_available = true
    notification.custom_data = {type:"new_publication",data:{ id:publication.id,version:publication.version,title:publication.title}}
    connection.write(notification.message)
    puts "Error: #{notification.error}." if notification.error
  end
  connection.close
end
  
def pushDelete(publication)
  require ENV["gcm_path"]
  pushGcmDelete(publication)
  
  registered = iphone_tokens(publication)
  unless registered.empty?
    certificate = File.read(ENV["certificate_path"])#ck_production
    connection = Houston::Connection.new(Houston::APPLE_PRODUCTION_GATEWAY_URI, certificate, ENV["password"])
    connection.open
    registered.each do |token|
      notification = Houston::Notification.new(device: token)
      notification.alert = "Event finished around you #{publication.title}" 
      # notification.badge = 1
      notification.sound = "default"
      notification.category = "ARRIVED_CATEGORY"
      notification.content_available = true
      notification.custom_data = {type:"deleted_publication",data:{ id:publication.id,version:publication.version,title:publication.title}}
      connection.write(notification.message)
      puts "Error: #{notification.error}." if notification.error
    end        
    connection.close
  end
end

def pushRegistered(publication, registration)
  
  registered = iphone_tokens(publication)
  unless registered.empty?
    certificate = File.read(ENV["certificate_path"])#ck_production
    connection = Houston::Connection.new(Houston::APPLE_PRODUCTION_GATEWAY_URI, certificate, ENV["password"])
    connection.open
    registered.each do |token|
      notification = Houston::Notification.new(device: token)
      notification.alert = "User comes to pick up #{publication.title}"
      # notification.badge = 1
      notification.sound = "default"
      notification.category = "ARRIVED_CATEGORY"
      notification.content_available = true
      notification.custom_data = {type:"registration_for_publication",data:{ id:publication.id,version:publication.version,date:registration.date_of_registration}}
      connection.write(notification.message)
      puts "Error: #{notification.error}." if notification.error
    end   
    connection.close
  end
end

def pushReport(publication, report)
  registered = iphone_tokens(publication)
  unless registered.empty?
    certificate = File.read(ENV["certificate_path"])#ck_production
    connection = Houston::Connection.new(Houston::APPLE_PRODUCTION_GATEWAY_URI, certificate, ENV["password"])
    connection.open
    registered.each do |token|
      notification = Houston::Notification.new(device: token)
      notification.alert = 'New report'
      # notification.badge = 1
      notification.sound = "default"
      notification.category = 'ARRIVED_CATEGORY'
      notification.content_available = true
      notification.custom_data = {type:"publication_report",data:{:publication_id=>publication.id,:publication_version=>publication.version,:date_of_report=>report.date_of_report, :report=>report.report}}
      connection.write(notification.message)
      puts "Error: #{notification.error}." if notification.error
    end       
    connection.close
  end
end

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

