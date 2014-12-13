class CreatePublicationReports < ActiveRecord::Migration
  def change
    create_table :publication_reports do |t|
      t.integer :unique_id, { null:false }
      t.integer :version, { null:false }
      t.integer :report
      t.date :date_of_report
      t.string :device_uuid, { limit:64 , null:false }

      t.timestamps
    end
  end
end
