class GroupMember < ActiveRecord::Base
	belongs_to :group
	#dependent: :destroy
	has_one :user 
	# dependent: :destroy

	validates :name, presence: true
	validates :Group_id, presence: true
	validates :phone_number, length: { in: 9..15 }

	before_validation :set_user
	# after_validation :normalize_phone

	def set_user
		self.user_id = 0
		users = User.where("uniphone = ?",self.phone_number.gsub(/[^\d]/, '').split(//).last(9).join)
		self.user_id = users.last.id unless users.empty?
	end

	def group_exists?
		return !self.group.nil?
	end

	def group
		return Group.find(self.Group_id)
	end

	def token
		device = ActiveDevice.find_by_dev_uuid(User.find(self.user_id).active_device_dev_uuid) 
		return {ios:device.is_ios, remote: device.remote_notification_token}
	rescue
		return {ios: false ,token: "no"}
	end

end
