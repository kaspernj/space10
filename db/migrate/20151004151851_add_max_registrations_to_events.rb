class AddMaxRegistrationsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :max_registrations, :integer
  end
end
