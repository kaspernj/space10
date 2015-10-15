class AddPublishAndContentFieldsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :content, :text
    add_column :posts, :publish_at, :datetime
    add_column :posts, :published, :boolean
  end
end
