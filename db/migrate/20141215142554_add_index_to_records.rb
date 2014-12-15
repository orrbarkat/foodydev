class AddIndexToRecords < ActiveRecord::Migration
  def change
  	add_index :active_devices, :is_ios
  	add_index :active_devices, :last_location_latitude
  	add_index :active_devices, :last_location_longitude
  	add_index :active_devices, :device_uuid
  	add_index :publication_reports, :unique_id
  	add_index :publication_reports, :version
  	add_index :publication_reports, :date_of_report
  	add_index :registered_user_for_publications, :unique_id
  end
end
