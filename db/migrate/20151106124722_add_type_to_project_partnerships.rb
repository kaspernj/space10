class AddTypeToProjectPartnerships < ActiveRecord::Migration
  def change
    add_column :project_partnerships, :type, :string
  end
end
