class CreateRegisteredUserForPublications < ActiveRecord::Migration
  def change
    create_table :registered_user_for_publications do |t|
      t.integer :publication_unique_id
      t.datetime :date_of_registration
      t.string :device_uuid

      t.timestamps
    end
  end
end
