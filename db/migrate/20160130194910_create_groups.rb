class CreateGroups < ActiveRecord::Migration
  def up
    create_table :groups do |t|
      t.belongs_to :user, index: true 
      t.string :name, {null:false}

      t.timestamps null: false
    end
  end

  def down
    	drop_table :groups
  end
end
