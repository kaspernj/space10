class AddIndexToProjectPartnerships < ActiveRecord::Migration
  def change
    add_index :project_partnerships, [:resource_id,:resource_type]
  end
end
