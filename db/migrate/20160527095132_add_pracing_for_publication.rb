class AddPracingForPublication < ActiveRecord::Migration
  def up
  	  	add_column :publications, :price, :float
  	  	add_column :publications, :price_desciption, :string

  end

  def down
  		remove_column :publications, :price
  		remove_column :publications, :price_desciption
  end
end
