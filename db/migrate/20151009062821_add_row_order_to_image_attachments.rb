class AddRowOrderToImageAttachments < ActiveRecord::Migration
  def change
    add_column :image_attachments, :row_order, :integer
  end
end
