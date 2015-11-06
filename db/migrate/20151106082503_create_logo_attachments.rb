class CreateLogoAttachments < ActiveRecord::Migration
  def change
    create_table :logo_attachments do |t|
      t.string :resource_type
      t.integer :resource_id
      t.string :image

      t.timestamps null: false
    end
  end
end
