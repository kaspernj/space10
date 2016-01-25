class AddRateableToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :rateable, :boolean
  end
end
