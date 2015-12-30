class ChangeDateColumnsType < ActiveRecord::Migration
  def change
  	remove_column :registered_user_for_publications, :date_of_registration, :datetime 
  	remove_column :publication_reports, :date_of_report, :date
  	add_column :registered_user_for_publications, :date_of_registration, :decimal
  	add_column :publication_reports, :date_of_report, :decimal 
  end
end
