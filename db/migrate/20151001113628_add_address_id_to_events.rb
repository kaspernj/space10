class AddAddressIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :address_id, :integer
  end
end
