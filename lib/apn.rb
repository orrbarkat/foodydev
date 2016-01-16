class Apn
	require 'houston'

	def self.client()	
		if ENV["password"]=="g334613f@@@"
			return Houston::Client.development
		else
			return Houston::Client.production
		end
	end

	def getTokens()
		registered = @publication.registered_user_for_publication
  		tokens = []
  		registered.each do |r|
    		if r.is_real && r.is_ios
      			tokens << r.token
    		end
  		end
	  	owner = ActiveDevice.find_by_dev_uuid(@publication.active_device_dev_uuid)
	  	if (owner!=nil && owner.is_iphone)
	    	tokens << owner.remote_notification_token
	  	end
	  	return tokens
	end

	def initialize(publication=nil, report=nil, registration=nil)
	    @publication=publication
	    @report=report
	    @registration=registration
	    @APN = Apn.client()
	    @APN.passphrase = ENV["password"]
	    @APN.certificate = File.read(ENV["certificate_path"])
  	end

  	def create
  		devices = ActiveDevice.where(is_ios: true).where.not(remote_notification_token: "no")
  		nots=[]
  		devices.each do |device|
  			notification = Houston::Notification.new(device: device.remote_notification_token)
  			notification.alert = "New event around you #{@publication.title}" 
          #notification.badge = 1
        notification.sound = "default"
        notification.category = "ARRIVED_CATEGORY"
        notification.content_available = true
        notification.custom_data = {type:"new_publication",data:{ id:@publication.id,version:@publication.version,title:@publication.title}}
        nots<<notification
      end
      @APN.push(nots)
      puts nots.map {|n| n.sent?}
    end

    def delete
      tokens== Apn.getTokens()
      nots=[]
      tokens.each do |token|
        notification = Houston::Notification.new(device: token)
        #"909cb3d2629c81fd703e35a026d025b1f325e6174b4cb5955aa18dcbe87c3cbf"
        notification.alert = "Event finished around you #{@publication.title}" 
        #notification.badge = 1
        notification.sound = "default"
        notification.category = "ARRIVED_CATEGORY"
        notification.content_available = true
        notification.custom_data = {type:"deleted_publication",data:{ id:@publication.id,version:@publication.version,title:@publication.title}}
        nots<<notification
      end
      @APN.push(nots)
      puts nots.map {|n| n.sent?}
    end

    def register
      tokens== Apn.getTokens()
      nots=[]
      tokens.each do |token|
        notification = Houston::Notification.new(device: token)
        notification.alert = "User comes to pick up #{@publication.title}"
        #notification.badge = 1
        notification.sound = "default"
        notification.category = "ARRIVED_CATEGORY"
        notification.content_available = true
        notification.custom_data = {type:"registration_for_publication",data:{ id:@publication.id,version:@publication.version,date:@registration.date_of_registration}}
        nots<<notification
      end
      @APN.push(nots)
      puts nots.map {|n| n.sent?}
    end

    def report
      tokens== Apn.getTokens()
      nots=[]
      tokens.each do |token|
        notification = Houston::Notification.new(device: token)
        notifinotification.alert = 'New report'
        #notification.badge = 1
        notification.sound = "default"
        notification.category = 'ARRIVED_CATEGORY'
        notification.content_available = true
        notification.custom_data = {type:"publication_report",data:{:publication_id=>@publication.id,:publication_version=>@publication.version,:date_of_report=>@report.date_of_report, :report=>@report.report}}
        nots<<notification
      end
      @APN.push(nots)
      puts nots.map {|n| n.sent?}
    end

end
require 'houston'

  class << self
    def connection(certificate)
      if ENV["password"]=="fdprod77457745"
        puts ENV["password"]
        return Houston::Connection.new(Houston::APPLE_PRODUCTION_GATEWAY_URI, certificate, ENV["password"])
      end
      conn = Houston::Connection.new(Houston::APPLE_DEVELOPMENT_GATEWAY_URI, certificate, ENV["password"])
      return conn
    end

    def getTokens(publication)
      registered = publication.registered_user_for_publication
        #i=0
        tokens = []
        registered.each do |r|
          if r.is_real && r.is_ios
              tokens << r.token
            #i=i+1
          end
        end
        owner = ActiveDevice.find_by_dev_uuid(publication.active_device_dev_uuid)
        if (owner!=nil && owner.is_iphone)
          tokens << owner.remote_notification_token
        end
        return tokens
    end
  end

  @@cert = File.read(ENV["certificate_path"])
  @@connection = Apn.connection(@@cert)
  
  def initialize(publication=nil, report=nil, registration=nil)
      @publication=publication
      @report=report
      @registration=registration
    end

    def create
      devices = ActiveDevice.where(is_ios: true).where.not(remote_notification_token: "no")
    done = devices.length
    while done>0
      begin
        @@connection.open
        done-=1
        next if (devices[done].remote_notification_token.length != 64)
        notification = Houston::Notification.new(device: devices[done].remote_notification_token)
        #"909cb3d2629c81fd703e35a026d025b1f325e6174b4cb5955aa18dcbe87c3cbf"
        notification.alert = "New event around you #{@publication.title}" 
            #notification.badge = 1
          notification.sound = "default"
          notification.category = "ARRIVED_CATEGORY"
          notification.content_available = true
          notification.custom_data = {type:"new_publication",data:{ id:@publication.id,version:@publication.version,title:@publication.title}}
            
          @@connection.write(notification.message)
          puts "Error: #{notification.error}." if notification.error
      rescue Errno::EPIPE => e
          Rails.logger.warn "Unable to push, will ignore: #{e}"
          @@connection.open
      end
    
    @@connection.close
    end 
  end

    def delete
      registered = Apn.getTokens(@publication)
      done = registered.length
    @@connection.open
    while done>0
      begin
        @@connection.open
        done-=1
          notification = Houston::Notification.new(device: registered[done])
          #"909cb3d2629c81fd703e35a026d025b1f325e6174b4cb5955aa18dcbe87c3cbf"
          notification.alert = "Event finished around you #{@publication.title}" 
          #notification.badge = 1
            notification.sound = "default"
            notification.category = "ARRIVED_CATEGORY"
          notification.content_available = true
          notification.custom_data = {type:"deleted_publication",data:{ id:@publication.id,version:@publication.version,title:@publication.title}}
          @@connection.write(notification.message)
          puts "Error: #{notification.error}." if notification.error
        rescue Errno::EPIPE => e
          logger.warn "Unable to push, will ignore: #{e}"
      end
      @@connection.close
    end      
    end

    def register
      registered = Apn.getTokens(@publication)
      done = registered.length
    while done>0
      begin
          @@connection.open
            done-=1
            notification = Houston::Notification.new(device: registered[done])
            #"909cb3d2629c81fd703e35a026d025b1f325e6174b4cb5955aa18dcbe87c3cbf"
            notification.alert = "User comes to pick up #{@publication.title}"
            #notification.badge = 1
            notification.sound = "default"
            notification.category = "ARRIVED_CATEGORY"
            notification.content_available = true
            notification.custom_data = {type:"registration_for_publication",data:{ id:@publication.id,version:@publication.version,date:@registration.date_of_registration}}
            @@connection.write(notification.message)
            puts "Error: #{notification.error}." if notification.error
        rescue Errno::EPIPE => e
          logger.warn "Unable to push, will ignore: #{e}"
      end
      @@connection.close
    end     
  end

    def report
      registered = Apn.getTokens(@publication)
      done = registered.length
    while done>0
      begin
        @@connection.open
            done-=1
            notification = Houston::Notification.new(device: registered[done])
            #"909cb3d2629c81fd703e35a026d025b1f325e6174b4cb5955aa18dcbe87c3cbf"
            notification.alert = 'New report'
            #notification.badge = 1
            notification.sound = "default"
            notification.category = 'ARRIVED_CATEGORY'
            notification.content_available = true
            notification.custom_data = {type:"publication_report",data:{:publication_id=>@publication.id,:publication_version=>@publication.version,:date_of_report=>@report.date_of_report, :report=>@report.report}}
            @@connection.write(notification.message)
            puts "Error: #{notification.error}." if notification.error
        rescue Errno::EPIPE => e
          logger.warn "Unable to push, will ignore: #{e}"
      end
      @@connection.close
    end      
    end
