class CreateActiveDevices < ActiveRecord::Migration
  def change
    create_table :active_devices do |t|
      t.string :remote_notification_token
      t.boolean :is_ios
      t.decimal :last_location_latitude
      t.decimal :last_location_longitude
      t.string :device_uuid

      t.timestamps
    end
  end
end
