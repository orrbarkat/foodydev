class Push
	attr_accessor :apn, :gcm, :publication, :report, :registration

	def initialize(publication, report=nil, registration=nil)
		@publication = publication
		@report=report
	    @registration=registration
    	@apn = Apn.new(@publication,@report,@registration)
    	@gcm = Gcm.new(@publication,@report,@registration)
  	end

  	def create
  		@gcm.create
  		@apn.create
  	end

  	def delete
  		@gcm.delete
  		@apn.delete
  	end

  	def register
  		@gcm.register
  		@apn.register
  	end

  	def report
  		@gcm.report
  		@apn.report
  	end
end

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
      tokens= getTokens()
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
      tokens= getTokens()
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
      tokens= getTokens()
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


class Gcm
	require "net/https"
	require "uri"
	require 'json'
	
	class << self
		
		def group
			if ENV["password"]=="fdprod77457745"
				return "/topics/prod"
			else
				return "/topics/dev"
			end
		end

	end

	def initialize(publication, report=nil, registration=nil)
	    @publication=publication
	    @report=report
	    @registration=registration
	end

	def android_tokens()
		  registered = @publication.registered_user_for_publication if not @publication.nil?
		  tokens = []
		  registered.each do |r|
		    if (r.is_real && !(r.is_ios))
		      tokens << r.token
		    end
		  end
		  owner = ActiveDevice.find_by_dev_uuid(@publication.active_device_dev_uuid)
		  if (owner!=nil && owner.is_android)
			tokens<<owner.remote_notification_token
		  end
		  return tokens
		end

	def create
		uri = URI.parse("https://android.googleapis.com/gcm/send")
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE
		request = Net::HTTP::Post.new(uri.request_uri)
		request["authorization"] = "key=AIzaSyCJbsdVaI0yajvOgrQRiUkbuC-s7XFWZhk"
		request["content-type"] = "application/json"
		request.body = {:to => Gcm.group, :data => {:message => {:type=> 'new_publication', :id=> @publication.id}}}.to_json #topics send to all app owners
		response = http.request(request)
		puts request.body
		puts response
		puts response.code
	end
# change :to  - :registration_ids
# fix tokens.nil/empty
# move android dev to production server
	def delete
		tokens = android_tokens() 
		unless tokens.empty?
			uri = URI.parse("https://android.googleapis.com/gcm/send")
			http = Net::HTTP.new(uri.host, uri.port)
			http.use_ssl = true
			http.verify_mode = OpenSSL::SSL::VERIFY_NONE
			request = Net::HTTP::Post.new(uri.request_uri)
			request["authorization"] = "key=AIzaSyCJbsdVaI0yajvOgrQRiUkbuC-s7XFWZhk"
			request["content-type"] = "application/json"
			request.body = {:registration_ids => tokens,:data => {:message => {:type => "deleted_publication",:id => @publication.id}}}.to_json 
			response = http.request(request)
			puts response
			puts response.code
			puts response.message
		end
	end

	def register
		tokens = android_tokens() 
		unless tokens.empty?
			uri = URI.parse("https://android.googleapis.com/gcm/send")
			http = Net::HTTP.new(uri.host, uri.port)
			http.use_ssl = true
			http.verify_mode = OpenSSL::SSL::VERIFY_NONE
			request = Net::HTTP::Post.new(uri.request_uri)
			request["authorization"] = "key=AIzaSyCJbsdVaI0yajvOgrQRiUkbuC-s7XFWZhk"
			request["content-type"] = "application/json"
			request.body = {:registration_ids=>tokens,:data=>{:message=>{:type=>"registeration_for_publication",:id => @publication.id}}}.to_json 
			response = http.request(request)
			puts response
			puts response.code
		end
	end

	def report
		tokens = android_tokens() 
		unless tokens.empty?
			uri = URI.parse("https://android.googleapis.com/gcm/send")
			http = Net::HTTP.new(uri.host, uri.port)
			http.use_ssl = true
			http.verify_mode = OpenSSL::SSL::VERIFY_NONE
			request = Net::HTTP::Post.new(uri.request_uri)
			request["authorization"] = "key=AIzaSyCJbsdVaI0yajvOgrQRiUkbuC-s7XFWZhk"
			request["content-type"] = "application/json"
			request.body = {:registration_ids => tokens,:data => {:message => {:type=>"publication_report",:publication_id=>@publication.id,:publication_version=>@publication.version,:date_of_report=>@report.date_of_report, :report=>@report.report}}}.to_json
			response = http.request(request)
			puts response
			puts response.code
		end
	end

end


