class CreateProjectPartnerships < ActiveRecord::Migration
  def change
    create_table :project_partnerships do |t|
      t.string :resource_type
      t.integer :resource_id
      t.integer :partner_id

      t.timestamps null: false
    end
  end
end
