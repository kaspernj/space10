class AddLabIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :lab_id, :integer
  end
end
