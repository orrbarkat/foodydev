
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

	request.body = { "to"=> "/topics/global", "data": {"message" => "now it works like i wanted!"}}.to_json 

	response = http.request(request)
	puts response
	puts response.code
