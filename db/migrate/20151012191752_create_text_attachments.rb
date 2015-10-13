class CreateTextAttachments < ActiveRecord::Migration
  def change
    create_table :text_attachments do |t|
      t.string :resource_type
      t.integer :resource_id
      t.text :content

      t.timestamps null: false
    end
  end
end
