class CreateTenants < ActiveRecord::Migration
  def change
    create_table :tenants do |t|
      t.string :name
      t.integer :code
      t.string :description
      t.boolean :active
      t.integer :account_id

      t.timestamps
    end
    add_index :tenants, :account_id
  end
end
