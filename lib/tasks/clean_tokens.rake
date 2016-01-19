namespace :notification do 
	desc "clean bad tokens from db"
	task clean_tokens: :environment do
		require ENV["push_path"]
		APN = Apn.client()
		APN.passphrase = ENV["password"]
	    APN.certificate = File.read(ENV["certificate_path"])
		devices = ActiveDevice.where(is_ios: true).where.not(remote_notification_token: "no")
    	nots=[]
  		devices.each do |device|
			notification = Houston::Notification.new(device: device.remote_notification_token)
			notification.content_available = true
			nots<<notification
      	end
      	APN.push(nots)
      	puts APN.devices
	    APN.devices.each do |token|
	    	dev = ActiveDevice.find_by_remote_notification_token(token.gsub(/\s+/, ""))
	    	puts dev.update!(:remote_notification_token=>"no")
	    end
	    puts "done for today!"
	end
end