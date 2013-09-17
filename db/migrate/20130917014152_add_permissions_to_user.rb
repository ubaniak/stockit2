class AddPermissionsToUser < ActiveRecord::Migration
  def change
    add_column :users, :can_manage, :boolean, :default => false
    add_column :users, :can_sell, :boolean, :default => false
    add_column :users, :can_report, :boolean, :default => false
  end
end
