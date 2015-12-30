class ChangeColunmForPublications < ActiveRecord::Migration
  def change
  	change_column_null :publications, :contact_info, true
  end
end
