json.array!(@users) do |user|
  json.extract! user, :id, :identity_provider, :identity_provider_user_id, :identity_provider_token, :phone_number, :identity_provider_email, :identity_provider_user_name, :is_logged_in, :active_device_dev_uuid, :ratings, :cradits, :foodies
  json.url user_url(user, format: :json)
end
