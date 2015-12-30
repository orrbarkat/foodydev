json.array!(@feedbacks) do |feedback|
  json.extract! feedback, :id, :active_device_dev_uuid, :reporter_name, :report
  json.url feedback_url(feedback, format: :json)
end
