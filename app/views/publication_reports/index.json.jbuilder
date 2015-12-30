json.array!(@publication_reports) do |publication_report|
  json.extract! publication_report, :id, :publication_unique_id, :publication_version, :report, :date_of_report, :reporting_device_uuid
  json.url publication_report_url(publication_report, format: :json)
end
