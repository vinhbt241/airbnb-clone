class AddOwnerIdToProperty < ActiveRecord::Migration[6.0]
  def change
    add_reference :properties, :owner
  end
end
