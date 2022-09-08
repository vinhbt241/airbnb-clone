class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.references :property, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.date :from
      t.date :to

      t.timestamps
    end
  end
end
