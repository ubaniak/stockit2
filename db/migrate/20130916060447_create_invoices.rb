class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.date :date
      t.integer :account_id
      t.string :number
      t.boolean :tax

      t.timestamps
    end
  end
end
