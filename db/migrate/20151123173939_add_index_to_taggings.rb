class AddIndexToTaggings < ActiveRecord::Migration
  def change
    add_index :taggings, [:resource_id,:resource_type]
  end
end
