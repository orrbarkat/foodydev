class AddMemberNotificationJob < ActiveJob::Base
  queue_as :default
  require ENV['push_path']

  def perform(group_id)
    Rails.logger.debug "#{self.class.name}: I'm performing my job with arguments: group_id#{group_id}"
    notifier = Push.new(nil,nil,nil,{group_id: group_id})
    notifier.new_member
  end
end
