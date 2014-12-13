class CreateActiveDevices < ActiveRecord::Migration
  def change
    create_table :active_devices do |t|
      t.string :remote_notification_token, { limit:64 , null:false }
      t.boolean :is_ios
      t.decimal :last_location_latitude, { null:false }
      t.decimal :last_location_longitude, { null:false }
      t.string :device_uuid, { limit:64 , null:false }

      t.timestamps
    end
  end
end
