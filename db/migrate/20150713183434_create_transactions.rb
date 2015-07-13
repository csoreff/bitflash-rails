class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :friendship_id, null: false
      t.integer :sender_address_id, null: false
      t.integer :recipient_address_id, null: false
      t.integer :amount, null: false

      t.timestamps null: false
    end
  end
end
