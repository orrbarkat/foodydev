class AddPhoneToRegistrated < ActiveRecord::Migration
  def up
  	add_column :registered_user_for_publications, :contact_info_regi, :string;
  	change_column :registered_user_for_publications, :contact_info_regi, :string, {limit:100, default: "", null:false};
  end

  def down
  	remove_column :registered_user_for_publications, :contact_info_regi
  end
end
