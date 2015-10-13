class CreateContentBlocks < ActiveRecord::Migration
  def change
    create_table :content_blocks do |t|
      t.string :type
      t.string :resource_type
      t.integer :resource_id

      t.timestamps null: false
    end
  end
end
