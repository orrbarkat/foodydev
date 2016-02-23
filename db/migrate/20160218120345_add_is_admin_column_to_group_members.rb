class AddIsAdminColumnToGroupMembers < ActiveRecord::Migration
  def up
  	add_column :group_members, :is_admin, :boolean
  end
  def down
  	remove_column :group_members, :is_admin
  end
end
