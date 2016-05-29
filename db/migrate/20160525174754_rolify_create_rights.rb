class RolifyCreateRights < ActiveRecord::Migration
  def change
    create_table(:rights) do |t|
      t.string :name
      t.references :resource, :polymorphic => true

      t.timestamps
    end

    create_table(:users_rights, :id => false) do |t|
      t.references :user
      t.references :rights
    end

    add_index(:rights, :name)
    add_index(:rights, [ :name, :resource_type, :resource_id ])
    add_index(:users_rights, [ :user_id, :rights_id ])
  end
end
