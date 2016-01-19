class SpecifictionForUsers < ActiveRecord::Migration
  def up
      change_column :users, :identity_provider_token, :string, {null:false}
      change_column :users, :phone_number, :string, {null:false}
      change_column :users, :identity_provider_email, :string, {null:false}
      change_column :users, :identity_provider_user_name, :string, {null:false}
      change_column :users, :is_logged_in, :boolean, {default:true}
      change_column :users, :active_device_dev_uuid, :string, {null:false}
      change_column :users, :cradits, :float, {default: 0}
      change_column :users, :foodies, :integer, {default: 0}

  end
  
  def down
  	  change_column :users, :identity_provider_token, :string
      change_column :users, :phone_number, :string
      change_column :users, :identity_provider_email, :string
      change_column :users, :identity_provider_user_name, :string
      change_column :users, :is_logged_in, :boolean
      change_column :users, :active_device_dev_uuid, :string
      change_column :users, :cradits, :float
      change_column :users, :foodies, :integer
  end
end
