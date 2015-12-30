class PublicationReportUserNameAndContactInfo < ActiveRecord::Migration
  
  def up
  	add_column :publication_reports, :report_user_name, :string;
  	add_column :publication_reports, :report_contact_info, :string;
  end

  def down
  	remove_column :publication_reports, :report_user_name
  	remove_column :publication_reports, :report_contact_info
  end
end
