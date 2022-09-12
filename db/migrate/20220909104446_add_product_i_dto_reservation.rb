class AddProductIDtoReservation < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :product_id, :string
  end
end
