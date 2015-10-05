class CreateImageAttachments < ActiveRecord::Migration
  def change
    create_table :image_attachments do |t|
      t.string :resource_type
      t.integer :resource_id
      t.string :title
      t.string :description

      t.timestamps null: false
    end
  end
end
