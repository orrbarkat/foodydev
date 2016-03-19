#heroku
if ENV["REDISCLOUD_URL"]
    $redis = Redis.new(:url => ENV["REDISCLOUD_URL"])
    # raise StandardError if !$redis.connected? 
#local
else
	$redis = Redis.new(:port => 6379) unless $redis 
	begin
		$redis.ping
	rescue Exception => e
		fork do
    		exec 'redis-server'
		end
	end
end

Resque.redis = $redis
# initialize resque server
require 'resque/server'