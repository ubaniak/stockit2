class ManageController < ApplicationController
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
end
