class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.date :date
      t.integer :account_id
      t.integer :user_id
      t.string :number

      t.timestamps
    end
  end
end
