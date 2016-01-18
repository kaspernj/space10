class AddTitleAndDescriptionToContentBlocks < ActiveRecord::Migration
  def change
    add_column :content_blocks, :title, :string
    add_column :content_blocks, :description, :string
  end
end
