json.array!(@publications) do |publication|
  json.extract! publication, :id, :publication_version, :publication_title, :publication_address, :publication_type_of_collecting, :publication_latitude, :publication_longitude, :publication_starting_date, :publication_ending_date, :publication_contact_info, :is_on_air, :reporting_device_uuid
  json.url publication_url(publication, format: :json)
end
