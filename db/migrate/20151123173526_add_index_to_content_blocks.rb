class AddIndexToContentBlocks < ActiveRecord::Migration
  def change
    add_index :content_blocks, [:resource_id,:resource_type]
  end
end
