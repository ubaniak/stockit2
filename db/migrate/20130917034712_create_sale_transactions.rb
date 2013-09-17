class CreateSaleTransactions < ActiveRecord::Migration
  def change
    create_table :sale_transactions do |t|
      t.integer :sale_id
      t.integer :stock_id
      t.integer :qty
      t.float :sell_price
      t.integer :user_id
      t.boolean :refunded, :default => false

      t.timestamps
    end
  end
end
