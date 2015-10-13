class AddRowOrderToContentBlocks < ActiveRecord::Migration
  def change
    add_column :content_blocks, :row_order, :integer
  end
end
