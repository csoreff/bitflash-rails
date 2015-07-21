class AddUserForeignKeyToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :user_id, :integer
    add_column :transactions, :recipient_id, :integer
  end
end
