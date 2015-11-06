class AddProjectPartnerstextToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :project_partners_text, :text
    add_column :posts, :project_people_text, :text
  end
end
