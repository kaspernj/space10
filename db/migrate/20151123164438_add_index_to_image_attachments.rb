class AddIndexToImageAttachments < ActiveRecord::Migration
  def change
    add_index :image_attachments, [:resource_id,:resource_type]
  end
end
