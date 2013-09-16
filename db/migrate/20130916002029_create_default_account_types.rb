class CreateDefaultAccountTypes < ActiveRecord::Migration
  def change
    create_table :default_account_types do |t|
        AccountType.new(:name => "supplier").save
        AccountType.new(:name => "till").save
        AccountType.new(:name => "bank").save
    end
  end
end
