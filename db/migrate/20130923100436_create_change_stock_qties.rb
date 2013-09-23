class CreateChangeStockQties < ActiveRecord::Migration
  def change
    create_table :change_stock_qties do |t|
      t.integer :stock_id
      t.integer :old_qty
      t.integer :qty
      t.date :date
      t.string :reason
      t.integer :user_id

      t.timestamps
    end
  end
end
