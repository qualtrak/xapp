class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.boolean :active
      t.string :email

      t.timestamps
    end
  end
end
