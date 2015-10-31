<<<<<<< Updated upstream:lib/gcm_dev_copy.rb
=======
require '/app/lib/clients.rb'

>>>>>>> Stashed changes:lib/gcm_dev.rb
def pushGcm(publication)
	require "net/https"
	require "uri"
	require 'json'
	
	uri = URI.parse("https://android.googleapis.com/gcm/send")
	http = Net::HTTP.new(uri.host, uri.port)
	http.use_ssl = true
	http.verify_mode = OpenSSL::SSL::VERIFY_NONE
	request = Net::HTTP::Post.new(uri.request_uri)
	request["authorization"] = "key=AIzaSyCJbsdVaI0yajvOgrQRiUkbuC-s7XFWZhk"
	request["content-type"] = "application/json"
	request.body = {:to => "/topics/global",:type => "new_publication",:data => {:id => publication.id}}.to_json #topics send to all app owners
	response = http.request(request)
	puts response
	puts response.code
end

def pushGcmDelete(publication)
	require "net/https"
	require "uri"
	require 'json'
	
	tokens = android_tokens(publication) 
	uri = URI.parse("https://android.googleapis.com/gcm/send")
	http = Net::HTTP.new(uri.host, uri.port)
	http.use_ssl = true
	http.verify_mode = OpenSSL::SSL::VERIFY_NONE
	request = Net::HTTP::Post.new(uri.request_uri)
	request["authorization"] = "key=AIzaSyCJbsdVaI0yajvOgrQRiUkbuC-s7XFWZhk"
	request["content-type"] = "application/json"
	request.body = {:to => tokens,:type => "deleted_publication",:data => {:id => publication.id}}.to_json 
	response = http.request(request)
	puts response
	puts response.code
end

def pushGcmReports(publication, report)
	require "net/https"
	require "uri"
	require 'json'
	
	tokens = android_tokens(publication) 
	owner = ActiveDevice.find_by dev_uuid: publication.active_device_dev_uuid
	if owner.is_android
		tokens<<owner.remote_notification_token
	end
	uri = URI.parse("https://android.googleapis.com/gcm/send")
	http = Net::HTTP.new(uri.host, uri.port)
	http.use_ssl = true
	http.verify_mode = OpenSSL::SSL::VERIFY_NONE
	request = Net::HTTP::Post.new(uri.request_uri)
	request["authorization"] = "key=AIzaSyCJbsdVaI0yajvOgrQRiUkbuC-s7XFWZhk"
	request["content-type"] = "application/json"
	request.body = {:to => tokens,:type => "publication_report",\
		:data => {:publication_id=>publication.id,:publication_version=>publication.version,:date_of_report=>report.date_of_report, :report=>report.report}}.to_json 
	response = http.request(request)
	puts response
	puts response.code
end

def pushGcmRegistered(publication)# tokens should have all registered non ios users + the oner, meaning the publication.active_dev....
	require "net/https"
	require "uri"
	require 'json'

	tokens = android_tokens(publication) 
	owner = ActiveDevice.find_by dev_uuid: publication.active_device_dev_uuid
	if owner.is_android
		tokens<<owner.remote_notification_token
	end
	uri = URI.parse("https://android.googleapis.com/gcm/send")
	http = Net::HTTP.new(uri.host, uri.port)
	http.use_ssl = true
	http.verify_mode = OpenSSL::SSL::VERIFY_NONE
	request = Net::HTTP::Post.new(uri.request_uri)
	request["authorization"] = "key=AIzaSyCJbsdVaI0yajvOgrQRiUkbuC-s7XFWZhk"
	request["content-type"] = "application/json"
	request.body = {:to=>tokens,:type=>"registeration_for_publication",:data => {:id => publication.id}}.to_json 
	response = http.request(request)
	puts response
	puts response.code
end