class CreateGroupMembers < ActiveRecord::Migration
  def up
    create_table :group_members do |t|
      t.belongs_to :Group, index: true
      t.integer :user_id, index: true, default: 0
      t.string :phone_number
      t.string :name, {null:false}

      t.timestamps null: false
    end
  end

  def down
  	drop_table :group_members
  end
end
