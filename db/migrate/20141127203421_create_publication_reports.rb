class CreatePublicationReports < ActiveRecord::Migration
  def change
    create_table :publication_reports do |t|
      t.integer :publication_unique_id
      t.integer :publication_version
      t.integer :report
      t.date :date_of_report
      t.string :reporting_device_uuid

      t.timestamps
    end
  end
end
