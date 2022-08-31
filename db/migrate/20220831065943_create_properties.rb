class CreateProperties < ActiveRecord::Migration[6.0]
  def change
    create_table :properties do |t|
      t.string :name 
      t.string :headline 
      t.text :description
      t.string :street
      t.string :city 
      t.string :state 
      t.string :country 
      t.float :latitude 
      t.float :longitude
      t.timestamps
    end

    add_index :properties, [:latitude, :longitude]
  end
end
