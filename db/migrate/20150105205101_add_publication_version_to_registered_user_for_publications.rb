class AddPublicationVersionToRegisteredUserForPublications < ActiveRecord::Migration
  def change
    add_column :registered_user_for_publications, :publication_version, :integer
  end
end
