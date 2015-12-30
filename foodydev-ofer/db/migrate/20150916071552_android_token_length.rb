class AndroidTokenLength < ActiveRecord::Migration
  
  def up
  	change_column :active_devices, :remote_notification_token, :string,{ limit:256, null:false};
  end

  def down
  	change_column :active_devices, :remote_notification_token, :string, { limit:64, null:false};
  end

end
