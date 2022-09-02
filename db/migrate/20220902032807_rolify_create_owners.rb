class RolifyCreateOwners < ActiveRecord::Migration[6.0]
  def change
    create_table(:owners) do |t|
      t.string :name
      t.references :resource, :polymorphic => true

      t.timestamps
    end

    create_table(:users_owners, :id => false) do |t|
      t.references :user
      t.references :owner
    end
    
    add_index(:owners, :name)
    add_index(:owners, [ :name, :resource_type, :resource_id ])
    add_index(:users_owners, [ :user_id, :owner_id ])
  end
end
