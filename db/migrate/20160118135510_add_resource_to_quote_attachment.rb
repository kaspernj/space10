class AddResourceToQuoteAttachment < ActiveRecord::Migration
  def change
    add_column :quote_attachments, :resource_type, :string
    add_column :quote_attachments, :resource_id, :integer
  end
end
