class ManageController < ApplicationController
    before_filter :authenticate_user!
    before_filter :can_manage

  def landing
  end

  def list_accounts
      @catagories = Catagory.all
  end

  def accounts
      @account_type = AccountType.new
      @account = Account.new
  end

  def stocks
      @catagory = Catagory.new
      @stock = Stock.new
  end

  def account_transfer
      @account_transfer = AccountTransfer.new
  end

  def bills
      @bill = Bill.new
  end

  def invoice
      @invoice = Invoice.new
      @invoice_item = InvoiceItem.new
      @catagories = Catagory.all
      @invoice_items = InvoiceItem.find_all_by_user_id(current_user.id)
  end

  def users
      @users = User.all
      @user = User.new
  end

  def create_default_sales_account
      account_type = AccountType.find_by_name("sale")
      if account_type.nil?
          AccountType.create(:name => "sale")
          account_type = AccountType.find_by_name("sale")
      end
      Account.create(:name => "Till", :account_type_id => account_type.id, :default_sales => true)
      redirect_to root_path, notice: "Default sales account created"
  end
end
