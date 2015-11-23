class AddIndexToLogoAttachments < ActiveRecord::Migration
  def change
    add_index :logo_attachments, [:resource_id,:resource_type]
  end
end
