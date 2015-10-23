class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :tag_id
      t.string :resource_type
      t.integer :resource_id

      t.timestamps null: false
    end
  end
end
