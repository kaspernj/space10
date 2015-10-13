class CreateVideoAttachments < ActiveRecord::Migration
  def change
    create_table :video_attachments do |t|
      t.string :title
      t.string :description
      t.boolean :featured
      t.string :provider
      t.string :video_id

      t.timestamps null: false
    end
  end
end
