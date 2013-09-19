class ManageController < ApplicationController
    before_filter :authenticate_user!
    before_filter :can_manage

  def landing
  end

  def accounts
      @account_types = AccountType.all
      @account_type = AccountType.new
      @account = Account.new
  end

  def stocks
      @catagories = Catagory.all
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
end
