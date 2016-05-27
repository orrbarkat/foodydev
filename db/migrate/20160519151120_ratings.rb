class Ratings < ActiveRecord::Migration
  def up
  	create_table :ratings do |t|
  		t.integer :publication_id, null:false
  		t.integer :publication_version, null:false
  		t.integer :rate,  null:false
  		t.integer :publisher_user_id
  		t.integer :reporter_user_id
  		t.timestamps null: false
  end
  end

  def down
  	drop_table :ratings
  end
end
