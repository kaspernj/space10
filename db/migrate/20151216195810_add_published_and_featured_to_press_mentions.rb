class AddPublishedAndFeaturedToPressMentions < ActiveRecord::Migration
  def change
    add_column :press_mentions, :published, :boolean
    add_column :press_mentions, :featured, :boolean
  end
end
