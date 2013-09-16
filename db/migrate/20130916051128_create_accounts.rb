class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.float :balance
      t.integer :account_type_id
      t.boolean :default_sales
      t.boolean :credit

      t.timestamps
    end
  end
end
