class CreateDefaultUser < ActiveRecord::Migration
  def change
    create_table :default_users do |t|
        User.create( :email => "admin@admin.com", :password => "asdf1234", :can_manage => true, :can_sell => true, :can_report => true )
    end
  end
end
