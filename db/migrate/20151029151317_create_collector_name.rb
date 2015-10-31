class CreateCollectorName < ActiveRecord::Migration
  def up
  	add_column :registered_user_for_publications, :collector_name, :string;
  	change_column :registered_user_for_publications, :collector_name, :string, {limit:100, default: "", null:false};
  end

  def down
  	remove_column :registered_user_for_publications, :collector_name
  end
end
