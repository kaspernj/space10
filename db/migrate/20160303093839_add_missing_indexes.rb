class AddMissingIndexes < ActiveRecord::Migration
  def change
    add_index :authentications, :user_id
    add_index :events, :address_id
    add_index :events, :lab_id
    add_index :posts, :lab_id
    add_index :profile_authorizations, :user_id
    add_index :profile_authorizations, :profile_id
    add_index :profiles, :user_id
    add_index :quote_attachments, [:resource_id, :resource_type]
    add_index :ratings, :user_id
    add_index :ratings, [:resource_id, :resource_type]
    add_index :registrations, :user_id
    add_index :registrations, :event_id
    add_index :taggings, :tag_id
    add_index :video_attachments, [:resource_id, :resource_type]
  end
end
