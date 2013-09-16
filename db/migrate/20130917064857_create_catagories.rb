class CreateCatagories < ActiveRecord::Migration
  def change
    create_table :catagories do |t|
      t.string :name
      t.integer :display_order
      t.boolean :priority

      t.timestamps
    end
  end
end
