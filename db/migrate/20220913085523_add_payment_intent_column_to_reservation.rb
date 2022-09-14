class AddPaymentIntentColumnToReservation < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :payment_intent, :string
  end
end
