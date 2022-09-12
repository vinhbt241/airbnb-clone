class AddPriceIdToProperty < ActiveRecord::Migration[6.0]
  def change
    add_column :properties, :price_id, :string
  end
end
