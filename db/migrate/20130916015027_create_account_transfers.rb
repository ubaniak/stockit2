class CreateAccountTransfers < ActiveRecord::Migration
  def change
    create_table :account_transfers do |t|
      t.integer :from
      t.integer :to
      t.float :amount
      t.string :reason
      t.boolean :payment
      t.date :date

      t.timestamps
    end
  end
end
