class CreateQuoteAttachments < ActiveRecord::Migration
  def change
    create_table :quote_attachments do |t|
      t.text :quote
      t.string :author

      t.timestamps null: false
    end
  end
end
