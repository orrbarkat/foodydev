class GroupMember < ActiveRecord::Base
	belongs_to :group, dependent: :destroy

	validates :user_id, presence: true

	before_validation :set_user

	def set_user
		self.user_id = User.find_by phone_number(self.phone_number.gsub(/[^\d]/, '').split(//).last(9).join).id ||= 0
	end

end
