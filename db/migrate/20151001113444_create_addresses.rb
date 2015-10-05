class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :name
      t.string :address_1
      t.string :address_2
      t.string :zipcode
      t.string :city
      t.string :country

      t.timestamps null: false
    end
  end
end
