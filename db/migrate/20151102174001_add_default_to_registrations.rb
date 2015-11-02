class AddDefaultToRegistrations < ActiveRecord::Migration
  def change
    change_column :registrations, :confirmed, :boolean, default: false, null: false
  end
end
