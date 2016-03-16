class AddUniphoneToUser < ActiveRecord::Migration
  def up
  	add_column :users, :uniphone, :text
  end

  def down
  	remove_column :users, :uniphone
  end
end
