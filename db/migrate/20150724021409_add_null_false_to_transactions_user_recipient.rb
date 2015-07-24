class AddNullFalseToTransactionsUserRecipient < ActiveRecord::Migration
  def change
    change_column :transactions, :user_id, :integer, null: false
    change_column :transactions, :recipient_id, :integer, null: false
  end
end
