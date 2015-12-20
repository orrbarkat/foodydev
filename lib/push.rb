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
  		@apn.create
  		@gcm.create
  	end

  	def delete
  		@apn.delete
  		@gcm.delete

  	end

  	def register
		@apn.register
  		@gcm.register
  	end

  	def report
  		@apn.report
  		@gcm.report
  	end
end

class Apn
	require 'houston'

	class << self
		def connection(certificate)
			if ENV["password"]=="fdprod77457745"
				return Houston::Connection.new(Houston::APPLE_PRODUCTION_GATEWAY_URI, certificate, ENV["password"])
			end
			return Houston::Connection.new(Houston::APPLE_DEVELOPMENT_GATEWAY_URI, certificate, ENV["password"])
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
		@@connection.open
		puts done
		puts devices.co
		while done>0
			begin
				done-=1
				puts devices[done].remote_notification_token=="909cb3d2629c81fd703e35a026d025b1f325e6174b4cb5955aa18dcbe87c3cbf"
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
				@@connection =  connection(@@cert)
				@@connection.open
   				logger.warn "Unable to push, will ignore: #{e}"
			end
		end
		 @@connection.close
	end

  	def delete
  		registered = Apn.getTokens(@publication)
  		done = registered.length
		@@connection.open
		while done>0
			begin
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
				@@connection =  connection(@@cert)
				@@connection.open
   				logger.warn "Unable to push, will ignore: #{e}"
			end
		end      
		@@connection.close
  	end

  	def register
	  	registered = Apn.getTokens(@publication)
  		done = registered.length
		@@connection.open
		while done>0
			begin
		   	done-=1
		    notification = Houston::Notification.new(device: registered[done])
		      notification = Houston::Notification.new(device: token)
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
				@@connection =  connection(@@cert)
				@@connection.open
   				logger.warn "Unable to push, will ignore: #{e}"
			end
		end      
		@@connection.close
	end

  	def report
  		registered = Apn.getTokens(@publication)
  		done = registered.length
		@@connection.open
		while done>0
			begin
		   	done-=1
		    notification = Houston::Notification.new(device: registered[done])
		      notification = Houston::Notification.new(device: token)
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
				@@connection =  connection(@@cert)
				@@connection.open
   				logger.warn "Unable to push, will ignore: #{e}"
			end
		end      
		@@connection.close
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

		def android_tokens(publication)
		  registered = publication.registered_user_for_publication
		  i=0
		  tokens = []
		  registered.each do |r|
		    if r.is_real && !(r.is_ios)
		      tokens [i] = r.token
		      i=i+1
		    end
		  end
		  owner = ActiveDevice.find_by_dev_uuid(publication.active_device_dev_uuid)
			if (owner!=nil && owner.is_android)
				tokens<<owner.remote_notification_token
			end
		  return tokens
		end
	end

	def initialize(publication, report=nil, registration=nil)
	    @publication=publication
	    @report=report
	    @registration=registration
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

	def delete
		tokens = android_tokens(publication) 
		unless tokens.empty?
			uri = URI.parse("https://android.googleapis.com/gcm/send")
			http = Net::HTTP.new(uri.host, uri.port)
			http.use_ssl = true
			http.verify_mode = OpenSSL::SSL::VERIFY_NONE
			request = Net::HTTP::Post.new(uri.request_uri)
			request["authorization"] = "key=AIzaSyCJbsdVaI0yajvOgrQRiUkbuC-s7XFWZhk"
			request["content-type"] = "application/json"
			request.body = {:to => tokens,:data => {:message => {:type => "deleted_publication",:id => @publication.id}}}.to_json 
			response = http.request(request)
			puts response
			puts response.code
		end
	end

	def register
		tokens = android_tokens(publication) 
		unless tokens.empty?
			uri = URI.parse("https://android.googleapis.com/gcm/send")
			http = Net::HTTP.new(uri.host, uri.port)
			http.use_ssl = true
			http.verify_mode = OpenSSL::SSL::VERIFY_NONE
			request = Net::HTTP::Post.new(uri.request_uri)
			request["authorization"] = "key=AIzaSyCJbsdVaI0yajvOgrQRiUkbuC-s7XFWZhk"
			request["content-type"] = "application/json"
			request.body = {:to=>tokens,:data=>{:message=>{:type=>"registeration_for_publication",:id => @publication.id}}}.to_json 
			response = http.request(request)
			puts response
			puts response.code
		end
	end

	def report
		tokens = android_tokens(publication) 
		unless tokens.empty?
			uri = URI.parse("https://android.googleapis.com/gcm/send")
			http = Net::HTTP.new(uri.host, uri.port)
			http.use_ssl = true
			http.verify_mode = OpenSSL::SSL::VERIFY_NONE
			request = Net::HTTP::Post.new(uri.request_uri)
			request["authorization"] = "key=AIzaSyCJbsdVaI0yajvOgrQRiUkbuC-s7XFWZhk"
			request["content-type"] = "application/json"
			request.body = {:to => tokens,:data => {:message => {:type=>"publication_report",:publication_id=>@publication.id,\
				:publication_version=>@publication.version,:date_of_report=>@report.date_of_report, :report=>@report.report}}}.to_json
			response = http.request(request)
			puts response
			puts response.code
		end
	end

end


