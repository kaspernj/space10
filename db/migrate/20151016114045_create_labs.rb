class CreateLabs < ActiveRecord::Migration
  def change
    create_table :labs do |t|
      t.string :title
      t.string :subtitle
      t.boolean :published
      t.datetime :starts_at
      t.datetime :ends_at

      t.timestamps null: false
    end
  end
end
