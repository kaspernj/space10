class CreateProfileAuthorizations < ActiveRecord::Migration
  def change
    create_table :profile_authorizations do |t|
      t.integer :user_id
      t.integer :profile_id

      t.timestamps null: false
    end
  end
end
