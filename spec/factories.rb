FactoryGirl.define do
  factory :publication do
    version 1
	title "MyText"
	address "MyText"
	type_of_collecting 1
	latitude 9.99
	longitude 9.99
	starting_date  {1.day.ago.to_i}
	ending_date  {1.day.from_now.to_i} 
	contact_info "MyText"
	is_on_air false
	active_device_dev_uuid "a0912a2f2c1a31fc"
  end

  factory :publication_report do
    publication_id {Publication.last.id}
    publication_version {Publication.last.version}
    report 3
    active_device_dev_uuid {ActiveDevice.last.dev_uuid}
    date_of_report {Time.now.to_i}
   	report_user_name "tester"
    report_contact_info "+972sfsfsfg"
  end

  factory :active_device do
	last_location_latitude 31.87980671
  	last_location_longitude 34.73339054
  	is_ios true
	remote_notification_token "909cb3d2629c81fd703e35a026d025b1f325e6174b4cb5955aa18dcbe87c3cbf"
	dev_uuid "guyfreedman"

  	trait :android do
  		is_ios false
		remote_notification_token "dLt-nR0QfBg:APA91bECl81HuSDZ7AyYOnsyb9EpoGQ71N16bwfzla5I4eq5McjYyt-qVXy1fkVCZ0vlTPxzfVo5dgEqqItUsYJzjCd9wl9qLpZydw4VUZf2nYCVezAl7gJBq_S-ky77tiCp5MK6KX9L"
	    dev_uuid "a0912a2f2c1a31fc"
	end
  end

  
end