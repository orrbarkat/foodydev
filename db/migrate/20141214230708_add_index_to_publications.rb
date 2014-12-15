class AddIndexToPublications < ActiveRecord::Migration
  def change
  	add_index :publications, :version
  	add_index :publications, :latitude
  	add_index :publications, :longitude
  	add_index :publications, :starting_date
  	add_index :publications, :ending_date
  	add_index :publications, :is_on_air
  end
end
