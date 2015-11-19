class AddProjectTextsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :project_partners_text, :text
    add_column :events, :project_people_text, :text
  end
end
