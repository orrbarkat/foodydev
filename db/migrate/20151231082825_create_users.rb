class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :identity_provider
      t.string :identity_provider_user_id
      t.string :identity_provider_token
      t.string :phone_number
      t.string :identity_provider_email
      t.string :identity_provider_user_name
      t.boolean :is_logged_in
      t.string :active_device_dev_uuid
      t.integer :ratings
      t.float :cradits
      t.integer :foodies

      t.timestamps null: false
    end
  end

  def down
    drop_table :users
  end
end
