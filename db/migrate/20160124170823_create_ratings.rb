class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :user_id
      t.string :resource_type
      t.integer :resource_id
      t.text :content
      t.integer :score

      t.timestamps null: false
    end
  end
end
