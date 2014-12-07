class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.integer :version
      t.text :title
      t.text :address
      t.integer :type_of_collecting
      t.decimal :latitude
      t.decimal :longitude
      t.datetime :starting_date
      t.datetime :ending_date
      t.text :contact_info
      t.boolean :is_on_air
      t.text :reporting_device_uuid

      t.timestamps
    end
  end
end
