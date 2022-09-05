class RemoveNameColumnFromProperty < ActiveRecord::Migration[6.0]
  def change
    remove_column :properties, :name
  end
end
