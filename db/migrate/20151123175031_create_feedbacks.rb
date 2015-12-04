class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :active_device_dev_uuid
      t.string :reporter_name
      t.string :report

      t.timestamps null: false
    end
  end
end
