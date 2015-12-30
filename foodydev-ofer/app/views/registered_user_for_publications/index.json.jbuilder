json.array!(@registered_user_for_publications) do |registered_user_for_publication|
  json.extract! registered_user_for_publication, :id, :publication_unique_id, :date_of_registration, :device_uuid
  json.url registered_user_for_publication_url(registered_user_for_publication, format: :json)
end
