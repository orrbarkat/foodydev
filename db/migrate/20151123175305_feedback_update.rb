class FeedbackUpdate < ActiveRecord::Migration
  def up
  	change_column :feedbacks, :reporter_name, :string, {limit:100, default: "no_name", null:true};
  	change_column :feedbacks, :report, :string, {limit:500, null:false};
  end
  
  def down
 	change_column :feedbacks, :reporter_name, :string;
  	change_column :feedbacks, :report, :string;
  end
end
