class AddClaimTokenToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :claim_token, :string
  end
end
