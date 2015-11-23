class AddIndexToTextAttachments < ActiveRecord::Migration
  def change
    add_index :text_attachments, [:resource_id,:resource_type]
  end
end
