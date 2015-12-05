class CreateFeedbacks < ActiveRecord::Migration
  def up
    create_table :feedbacks do |t|
      t.string :active_device_dev_uuid, {null: false}
      t.string :reporter_name, {limit:100, default: "no_name"};
      t.string :report, :string, {limit:500, null:false};

      t.timestamps null: false
    end
  end

  def down
  	drop_table :feedbacks
  end
end
