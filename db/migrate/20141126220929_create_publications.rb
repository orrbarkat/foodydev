class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.integer :publication_version
      t.text :publication_title
      t.text :publication_address
      t.integer :publication_type_of_collecting
      t.decimal :publication_latitude
      t.decimal :publication_longitude
      t.datetime :publication_starting_date
      t.datetime :publication_ending_date
      t.text :publication_contact_info
      t.boolean :is_on_air
      t.text :reporting_device_uuid

      t.timestamps
    end
  end
end
