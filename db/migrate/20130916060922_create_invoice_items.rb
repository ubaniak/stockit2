class CreateInvoiceItems < ActiveRecord::Migration
  def change
    create_table :invoice_items do |t|
      t.integer :invoice_id
      t.integer :stock_id
      t.integer :qty
      t.float :cost_price
      t.float :sell_price
      t.integer :min_stock
      t.integer :user_id


      t.timestamps
    end
  end
end
