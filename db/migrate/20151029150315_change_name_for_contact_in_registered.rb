class ChangeNameForContactInRegistered < ActiveRecord::Migration
  def up
  	rename_column :registered_user_for_publications, :contact_info_regi, :collector_contact_info
  end

  def down
  	rename_column :registered_user_for_publications, :collector_contact_info, :contact_info_regi
  end
end
