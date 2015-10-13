class AddVideoUrlToVideoAttachments < ActiveRecord::Migration
  def change
    add_column :video_attachments, :video_url, :string
  end
end
