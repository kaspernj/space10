class AddImageToVideoAttachments < ActiveRecord::Migration
  def change
    add_column :video_attachments, :image, :string
  end
end
