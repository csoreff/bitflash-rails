class CreateAddressesTable < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :user_id, null: false
      t.string :btc_address, null: false

      t.timestamps null: false
    end
  end
end
