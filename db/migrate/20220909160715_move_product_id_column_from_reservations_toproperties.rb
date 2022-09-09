class MoveProductIdColumnFromReservationsToproperties < ActiveRecord::Migration[6.0]
  def change
    remove_column :reservations, :product_id
    add_column :properties, :product_id, :string
  end
end
