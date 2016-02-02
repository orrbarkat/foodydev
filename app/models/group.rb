class Group < ActiveRecord::Base
	belongs_to :user, dependent: :destroy
	has_many :group_members

	validates :name, presence: true

end
