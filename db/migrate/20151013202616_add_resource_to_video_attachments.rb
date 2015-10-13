class AddResourceToVideoAttachments < ActiveRecord::Migration
  def change
    add_column :video_attachments, :resource_type, :string
    add_column :video_attachments, :resource_id, :integer
  end
end
