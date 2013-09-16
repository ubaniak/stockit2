class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.integer :account_id
      t.float :amount
      t.string :description
      t.date :date

      t.timestamps
    end
  end
end
