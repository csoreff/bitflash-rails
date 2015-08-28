module BtcaddressHelper
  def transaction_amount(transaction)
    if transaction.user_id == current_user.id
      transaction.amount * -1
    else
      transaction.amount
    end
  end

  def incoming_or_outgoing?(transaction)
    if transaction.user_id == current_user.id
      'Outgoing'
    else
      'Incoming'
    end
  end

  def get_btc_address(transaction)
    if transaction.user_id == current_user.id
      Btcaddress.find(transaction.recipient_address_id).address
    else
      Btcaddress.find(transaction.sender_address_id).address
    end
  end
end
