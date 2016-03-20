class CreatePublicationJob < ActiveJob::Base
  queue_as :default
  require ENV['push_path']
  
  def perform(pub_id)
    Rails.logger.debug "#{self.class.name}: I'm performing my job with arguments: #{pub_id}"
    @publication = Publication.find(pub_id)
    pushCreate
  end

protected
  def pushCreate
    push = Push.new(@publication)
    Rails.logger.debug push.create
  rescue => e
    Rails.logger.warn "Unable to push, will ignore: #{e}"
  end
end
