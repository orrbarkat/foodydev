class ChangesInExistingTables < ActiveRecord::Migration
  
  def up
  	# publications
  	add_column :publications, :publisher_id, :integer
  	add_column :publications, :audience, :integer
  	# publication report
  	add_column :publication_reports, :reporter_user_id, :integer
  	# registerd
  	add_column :registered_user_for_publications, :collector_user_id, :integer
  end
  
  def down
  	# publications
  	remove_column :publications, :publisher_id, :integer
  	remove_column :publications, :audience, :integer
  	# publication report
  	remove_column :publication_reports, :reporter_user_id, :integer
  	# registerd
  	remove_column :registered_user_for_publications, :collector_user_id, :integer
  end

end
