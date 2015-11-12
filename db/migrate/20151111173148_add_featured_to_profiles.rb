class AddFeaturedToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :featured, :boolean
  end
end
