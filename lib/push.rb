class Push
	attr_accessor :apn, :gcm, :publication, :user_report, :registration

	def initialize(publication=nil, report=nil, registration=nil, params = {})
		@publication = publication
		@user_report=report
	    @registration=registration
	    @params = params
    	@apn = Apn.new(@publication,report,@registration)
    	@gcm = Gcm.new(@publication,report,@registration)
  	end

  	def create
  		Rails.logger.warn "gcm now pushing"
  		@gcm.create
  		Rails.logger.warn "apn now pushing"
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

  	def new_member
  		return false unless @params[:group_id]
  		# @gcm.new_member(@params[:group_id])
  		@apn.new_member(@params[:group_id])
  	end

  	def remove_member
  		return false unless @params[:group_id]
  		# @gcm.new_member(@params[:group_id])
  		@apn.remove_member(@params[:group_id])
  	end

end

class Apn
	require 'houston'

	def self.client()	
		if ENV["S3_BUCKET"]=="foodcollectordev"
			return Houston::Client.development
		else
			return Houston::Client.production
		end
	end

	def self.gateway()	
		if ENV["S3_BUCKET"]=="foodcollectordev"
			return Houston::APPLE_DEVELOPMENT_GATEWAY_URI
		else
			return Houston::APPLE_PRODUCTION_GATEWAY_URI
		end
	end

	def getTokens()
		tokens = Array.new
		if @publication.audience == 0
			registered = @publication.registered_user_for_publication
			registered.each do |r|
	    		if r.is_real && r.is_ios
	      			tokens << r.token
	    		end
  			end
		else
			registered = GroupMember.where(Group_id: @publication.audience)
			registered.each do |r|
				r = r.token
				tokens << r.remote if (r.ios==true && r.remote!= "no")
			end
		end
	  	tokens = tokens.uniq
	  	tokens.delete(ActiveDevice.find_by_dev_uuid(@registration.active_device_dev_uuid).remote_notification_token) unless @registration.nil?
	  	tokens.delete(ActiveDevice.find_by_dev_uuid(@user_report.active_device_dev_uuid).remote_notification_token) unless @user_report.nil?
	  	return tokens
	end

	def owner()
		owner = ActiveDevice.find_by_dev_uuid(@publication.active_device_dev_uuid)
	  	return owner.remote_notification_token if (owner!=nil && owner.is_iphone)
    end

	def initialize(publication=nil, report=nil, registration=nil)
	    @publication=publication
	    @user_report=report
	    @registration=registration
	    @APN = Apn.client()
	    @APN.passphrase = ENV["password"]
	    @APN.certificate = File.read(ENV["certificate_path"])
  	end

  	def create
		if @publication.audience == 0
  			devices = ActiveDevice.where(is_ios: true).where.not(remote_notification_token: "no").to_a.reverse
  			devices.map!{|d| d.remote_notification_token} unless devices.empty?
  		else
  			devices = getTokens
  		end
  		nots=[]
  		devices.uniq.each do |token|
  			notification = Houston::Notification.new(device: token)
  			notification.sound = ""
			notification.category = 'ARRIVED_CATEGORY'
			notification.content_available = true
			notification.custom_data = {type:'new_publication',data:{ 
				id: @publication.id, 
				version:@publication.version, 
				title:@publication.title,
				latitude:@publication.latitude,
				longitude: @publication.longitude
				}}
	        nots<<notification 
	        nots = push(nots) if nots.size == 20
	    end
	    push(nots)
    rescue => e
    	Rails.logger.warn "Unable to push, will ignore: #{e}"
    end

    def delete
      tokens= getTokens()
      nots=[]
      tokens.each do |token|
        notification = Houston::Notification.new(device: token)
  			notification.sound = ""
			notification.category = 'ARRIVED_CATEGORY'
			notification.content_available = true
			notification.custom_data = {type:"deleted_publication",data:{ 
				id:@publication.id,
				version:@publication.version,
				title:@publication.title,
				latitude:@publication.latitude,
				longitude: @publication.longitude
				}}
        #"909cb3d2629c81fd703e35a026d025b1f325e6174b4cb5955aa18dcbe87c3cbf"
        # notification.alert = "Event finished around you #{@publication.title}" 
        # #notification.badge = 1
        # notification.sound = "default"
        # notification.category = "ARRIVED_CATEGORY"
        # notification.content_available = true
        # notification.custom_data = {type:"deleted_publication",data:{ id:@publication.id,version:@publication.version,title:@publication.title}}
        nots<<notification
        nots = push(nots) if nots.size == 20
      end
      push(nots)
      return nots.map {|n| n.sent?}
    rescue => e
    	Rails.logger.warn "Unable to push, will ignore: #{e}"
    end

    def register
      tokens= getTokens()
      tokens<<owner()
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
        nots = push(nots) if nots.size == 20
      end
      push(nots)
      return nots.map {|n| n.sent?}
    rescue => e
    	Rails.logger.warn "Unable to push, will ignore: #{e}"
    end

    def report
    	begin
	      tokens= getTokens()
	      tokens<<owner()
	      nots=[]
	      tokens.each do |token|
	        notification = Houston::Notification.new(device: token)
	        notification.alert = 'New report'
	        #notification.badge = 1
	        notification.sound = "default"
	        notification.category = 'ARRIVED_CATEGORY'
	        notification.content_available = true
	        notification.custom_data = {type:"publication_report",data:{:publication_id=>@publication.id,:publication_version=>@publication.version,:date_of_report=>@user_report.date_of_report, :report=>@user_report.report}}
	        nots<<notification
	      end
	      @APN.push(nots)
	      puts nots.map {|n| n.sent?}
        rescue => e
	    	broken = @APN.devices
	    	broken.each do |token|
	    		dev = ActiveDevice.find_by_remote_notification_token(token.gsub(/\s+/, ""))
	    		puts dev.update!(:remote_notification_token=>"no")
	    	end
	    	Rails.logger.warn "Unable to push, will ignore: #{e}"
	  end
    end

    def new_member(id)
      tokens= getMembers(id)
      group_name = Group.find(id).name
      nots=[]
      tokens.each do |token|
        notification = Houston::Notification.new(device: token)
        notification.sound = "" 
		notification.category = 'ARRIVED_CATEGORY'
		notification.content_available = true 
		notification.custom_data = {type:"group_members",data:{ 
			id: id,
	 	 	title:group_name
	 	}}
        nots<<notification
        nots = push(nots) if nots.size == 20
      end
      push(nots)
      return nots.map {|n| n.sent?}
    # rescue => e
    # 	Rails.logger.warn "Unable to push, will ignore: #{e}"
    end

   def remove_member(id)
      tokens= getMembers(id)
      group_name = Group.find(id).name
      nots=[]
      tokens.each do |token|
        notification = Houston::Notification.new(device: token)
        notification.sound = "" 
		notification.category = 'ARRIVED_CATEGORY'
		notification.content_available = true 
		notification.custom_data = {type:"group_members",data:{ 
			id: id,
	 	 	title:group_name
	 	}}
        nots<<notification
        nots = push(nots) if nots.size == 20
      end
      Rails.logger.warn "arived to push"
      push(nots)

      return nots.map {|n| n.sent?}
    # rescue => e
    # 	Rails.logger.warn "Unable to push, will ignore: #{e}"
    end


protected
	def push(nots)
		connection = Houston::Connection.new(Apn.gateway(), @APN.certificate, @APN.passphrase)
		connection.open
		nots.each do |notification|
			connection.write(notification.message)
			Rails.logger.warn notification.token
		end
		err = bad_notification(connection)
		if err == "Invalid token"
			nots.reverse.each do |notification|
				connection.open
				connection.write(notification.message)
				error = bad_notification(connection)
				clean_token(notification.token) if error=="Invalid token"
			end
		end
		return []
	end

	def bad_notification(connection)
		notification = Houston::Notification.new(device: "e4a20accbd6a8ecb0d3626eeaaddba2c16b93f2098d8a5c36926515ecea5c154") 
		notification.sound = ""
		notification.category = 'ARRIVED_CATEGORY'
		notification.content_available = true
		latitudeValue = @APN.certificate
		longitudeValue =  34.934218898539093
		notification.custom_data = {type:"new_publication",data:{ id:3,version:1,title:"", latitude: latitudeValue, longitude: longitudeValue }}
		connection.write(notification.message)
		sleep 1
		if error = connection.read(6)
		  command, status, index = error.unpack("ccN")
		  notification.apns_error_code = status
		end
		connection.close
		puts "bad notification sent"
		puts notification.error
		return notification.error.to_s
	end

	def clean_token(token)
		puts dev = ActiveDevice.find_by_remote_notification_token(token.gsub(/\s+/, ""))
	    dev.remote_notification_token="no" unless dev.nil?
	    dev.save!
	    puts dev.remote_notification_token
	end

	def getMembers(group_id)
		registered = GroupMember.where(Group_id: group_id)
		tokens = []
		registered.each do |r|
			next if r.is_admin
			r = r.token
			tokens << r[:remote] if (r[:ios]==true && r[:remote]!= "no")
		end
		return tokens
	end
end


class Gcm
	require "net/https"
	require "uri"
	require 'json'

	attr_accessor :publication, :user_report, :registration
	
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
	    @user_report=report
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
	  	tokens = tokens.uniq
	  	tokens.delete(@registration.active_device_dev_uuid) unless @registration.nil?
	  	tokens.delete(self.user_report.active_device_dev_uuid) unless @user_report.nil?
	  	return tokens
	end

	def getOwner()
		owner = ActiveDevice.find_by_dev_uuid(@publication.active_device_dev_uuid)
		return owner.remote_notification_token if (owner!=nil && owner.is_android)
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
		tokens<<getOwner() 
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
		tokens<<getOwner() 
		unless tokens.empty?
			uri = URI.parse("https://android.googleapis.com/gcm/send")
			http = Net::HTTP.new(uri.host, uri.port)
			http.use_ssl = true
			http.verify_mode = OpenSSL::SSL::VERIFY_NONE
			request = Net::HTTP::Post.new(uri.request_uri)
			request["authorization"] = "key=AIzaSyCJbsdVaI0yajvOgrQRiUkbuC-s7XFWZhk"
			request["content-type"] = "application/json"
			request.body = {:registration_ids => tokens,:data => {:message => {:type=>"publication_report",:publication_id=>@publication.id,:publication_version=>@publication.version,:date_of_report=>@user_report.date_of_report, :report=>@user_report.report}}}.to_json
			response = http.request(request)
			puts response
			puts response.code
		end
	end

end


