class CreatePublicationReports < ActiveRecord::Migration
  def change
    create_table :publication_reports do |t|
      t.integer :publication_id, { null:false }
      t.integer :publication_version, { null:false }
      t.integer :report
      t.date :date_of_report
      t.string :active_device_dev_uuid, { limit:64 , null:false }

      t.timestamps
    end
  end
end
