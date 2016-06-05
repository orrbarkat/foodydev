class PublicationTypoFixAndDefultAudience < ActiveRecord::Migration
  def up
  	change_column :publications, :audience, :integer, {default: 0}
  	rename_column :publications, :price_desciption, :price_description
  end

  def down
  	change_column :publications, :audience, :integer
  	rename_column :publications, :price_description, :price_desciption
  end
end
