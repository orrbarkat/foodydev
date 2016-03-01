class AddUsernameToPublication < ActiveRecord::Migration
  def up
  	add_column :publications, :identity_provider_user_name, :text
  end

  def down
  	remove_column :publications, :identity_provider_user_name
  end
end
