class CreateRefunds < ActiveRecord::Migration
  def change
    create_table :refunds do |t|
      t.date :date
      t.integer :user_id
      t.date :sale_date
      t.integer :stock_id
      t.integer :qty
      t.float :sell_price
      

      t.timestamps
    end
  end
end
