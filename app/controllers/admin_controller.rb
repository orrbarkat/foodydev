class AdminController < ApplicationController
  def index
  	@stats = user_count(ActiveDevice.all)
  end

  def login
  end

private
	def user_count(users)
		t = Time.now.at_beginning_of_week
		res = []
		10.times do |i|
			t -= 1.week
			if users.nil?
				week_users = []
			else
				week_users = users.select{|u| t<=u.created_at && u.created_at< t+1.week}
			end
			ios = 0
			android = 0
			week_users.each do |user|
				user.is_ios==true ? (ios+=1) : (android+=1)
			end
			res<< {date: t , ios: ios, android: android}
		end
		return res
	end

end
