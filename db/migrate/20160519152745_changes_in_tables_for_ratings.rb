class ChangesInTablesForRatings < ActiveRecord::Migration
  def up
  	add_column :users , :ratings_count, :integer
    change_column :users, :ratings, :float 
  	add_column :publication_reports, :rating, :integer
  	add_column :publications, :user_rating, :integer
  end
  def down
  	remove_column :users , :ratings_count, :integer
    change_column :users, :ratings, :integer
  	remove_column :publication_reports, :rating, :integer
  	remove_column :publications, :user_rating, :integer
  end
end
