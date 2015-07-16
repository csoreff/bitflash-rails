class ChangeAddressTable < ActiveRecord::Migration
  def change
    rename_column('addresses', 'btc_address', 'address')
    rename_table('addresses', 'btcaddresses')
  end
end
