class AddPersonIdToProjectPartnerships < ActiveRecord::Migration
  def change
    add_column :project_partnerships, :person_id, :integer
  end
end
