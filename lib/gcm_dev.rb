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
	request.body = {:to => tokens,:type => "new_publication",:data => {:id => publication.id}}.to_json 
	response = http.request(request)
	puts response
	puts response.code
end

def pushGcmDelete(publication, tokens)
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
	request.body = {:to => tokens,:type => "deleted_publication",:data => {:id => publication.id}}.to_json 
	response = http.request(request)
	puts response
	puts response.code
end

def pushGcmReports(publication, tokens)
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
	request.body = {:to => tokens,:type => "publication_report",:data => {:id => publication.id,\
	 :publication_version => publication.version, :date_of_report => ""}}.to_json 
	response = http.request(request)
	puts response
	puts response.code
end
#{type:”publication_report”,”data" : { “publication_id” : 215, “publication_version” : 1, “date_of_report”:11111112, “report” :5}}

def pushGcmRegistered(publication, tokens)
end

