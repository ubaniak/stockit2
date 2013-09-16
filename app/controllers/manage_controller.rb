class ManageController < ApplicationController
  def accounts
      @account_types = AccountType.all
      @account_type = AccountType.new
      @account = Account.new
  end

  def stocks
  end

  def account_transfer
  end

  def bills
  end
end
