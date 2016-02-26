class GroupMember < ActiveRecord::Base
	belongs_to :group, dependent: :destroy
	has_one :user 
	# dependent: :destroy

	validates :name, presence: true
	validates :Group_id, presence: true

	before_validation :normalize_phone, :set_user

	def set_user
		self.user_id = 0
		users = User.where("phone_number = ?",self.phone_number)
		self.user_id = users.last.id unless users.empty?
	end

	def normalize_phone
      	self.phone_number = self.phone_number.gsub(/[^\d]/, '').split(//).last(9).join
      end

	def group_exists?
		return !self.group.nil?
	end

	def group
		return Group.find(self.Group_id)
	end
end
