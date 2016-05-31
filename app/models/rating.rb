class Rating < ActiveRecord::Base
	belongs_to :publication

	  validates :publication_id, null:false
  	validates :publication_version, null:false
  	validates :rate,  null:false

  	before_save :update_user

  	def update_user
  		user_id  = Publication.find(publication_id).publisher_id
  		@user = User.find(user_id)
			@user.ratings=0 if @user.ratings.nil?
			@user.ratings_count=0 if @user.ratings_count.nil?
			@user.ratings_count = @user.ratings_count + 1
  		@user.ratings = (@user.ratings*(@user.ratings_count) + self.rate)/(@user.ratings_count)
  		@user.save!
  	end
end
