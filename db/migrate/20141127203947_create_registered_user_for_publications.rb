class CreateRegisteredUserForPublications < ActiveRecord::Migration
  def change
    create_table :registered_user_for_publications do |t|
      t.integer :publication_id, { null: false }
      t.datetime :date_of_registration
      t.string :active_device_dev_uuid, { limit: 64 , null: false }

      t.timestamps
    end
  end
end
