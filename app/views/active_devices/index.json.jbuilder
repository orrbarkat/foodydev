json.array!(@active_devices) do |active_device|
  json.extract! active_device, :id, :remote_notification_token, :is_ios, :last_location_latitude, :last_location_longitude, :device_uuid
  json.url active_device_url(active_device, format: :json)
end
