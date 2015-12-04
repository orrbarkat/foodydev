class CreateFeedbacks < ActiveRecord::Migration
  def up
    create_table :feedbacks do |t|
      t.string :active_device_dev_uuid
      t.string :reporter_name
      t.string :report

      t.timestamps null: false
    end
    def down
    	drop_table :feedbacks
    end
    	
    end
  end
end
