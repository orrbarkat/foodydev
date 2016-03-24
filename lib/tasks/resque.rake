require 'resque/tasks'

task "resque:setup" => :environment do
	ENV['QUEUE'] = '*'
  Resque.before_fork = Proc.new do |job|
    ActiveRecord::Base.connection.disconnect!
  end
  Resque.after_fork = Proc.new do |job|
    ActiveRecord::Base.establish_connection
  end
end

desc "Alias for resque:work (To run workers on Heroku)"
task "jobs:work" => "resque:work"