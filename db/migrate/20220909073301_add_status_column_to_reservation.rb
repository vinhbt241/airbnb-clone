class AddStatusColumnToReservation < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :status, :string
  end
end
