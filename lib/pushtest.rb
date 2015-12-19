class Abc
	require 'Houston'

	class << self
		def connection(certificate)
			if ENV["password"]=="fdprod77457745"
				return Houston::Connection.new(Houston::APPLE_PRODUCTION_GATEWAY_URI, certificate, ENV["password"])
			end
			return Houston::Connection.new(Houston::APPLE_DEVELOPMENT_GATEWAY_URI, certificate, ENV["password"])
		end
	end

	@@cert = File.read(ENV["certificate_path"])
	@@connection = Abc.connection(@@cert)

	def initialize(item_name, publication=nil, report=nil, registration=nil)
	    @item_name = item_name
	    @publication=publication
	    @report=report
	    @registration=registration
  	end

end