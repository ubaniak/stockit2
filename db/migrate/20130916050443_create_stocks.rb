class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :name
      t.integer :catagory_id
      t.integer :qty
      t.float :cost_price
      t.float :sell_price
      t.integer :min_stock

      t.timestamps
    end
  end
end
