class AddImageToImageAttachments < ActiveRecord::Migration
  def change
    add_column :image_attachments, :image, :string
  end
end
