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
	request.body = {:to => "/topics/global", :data => {:message => {:type=> 'new_publication', :id=> publication.id}}}.to_json #topics send to all app owners
	response = http.request(request)
	puts request.body
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
	request.body = {:to => tokens,:data => {:message => {:type => "deleted_publication",:id => publication.id}}}.to_json 
	response = http.request(request)
	puts response
	puts response.code
end

def pushGcmReports(publication, new_report)
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
	request.body = {:to => tokens,:data => {:message => {:type=>"publication_report",:publication_id=>publication.id,\
		:publication_version=>publication.version,:date_of_report=>new_report.date_of_report, :report=>new_report.report}}}.to_json
	response = http.request(request)
	puts response
	puts response.code
end

def pushGcmRegistered(publication)# tokens should have all registered non ios users + the oner, meaning the publication.active_dev....
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
	request.body = {:to=>tokens,:data=>{:message=>{:type=>"registeration_for_publication",:id => publication.id}}}.to_json 
	response = http.request(request)
	puts response
	puts response.code
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
  owner = ActiveDevice.find_by dev_uuid: publication.active_device_dev_uuid
	if owner.is_android
		tokens<<owner.remote_notification_token
	end
  return tokens
end