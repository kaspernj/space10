class CreatePressMentions < ActiveRecord::Migration
  def change
    create_table :press_mentions do |t|
      t.string :title
      t.text :excerpt
      t.string :url
      t.string :source
      t.datetime :published_at
      t.string :image

      t.timestamps null: false
    end
  end
end
