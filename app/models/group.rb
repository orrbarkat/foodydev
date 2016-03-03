class Group < ActiveRecord::Base
	belongs_to :user
	has_many :group_members, foreign_key: :Group_id, primary_key: :id

	validates :name, presence: true
	validates_associated :group_members, :user

end
