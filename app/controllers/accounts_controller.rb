class AccountsController < ApplicationController
    before_filter :authenticate_user!
    before_filter :can_manage

    def index
        @account_types = AccountType.all
    end

    def edit
        @account = Account.find(params[:id])
    end

    def update
        @account = Account.find(params[:id])
        @account.update(:name => params[:name], :balance => params[:balance], :account_type_id => params[:account_type_id])
        redirect_to accounts_path, notice: "Account updated"
    end

    def create_account_type
        @account_type = AccountType.new(account_type_params)

        respond_to do |format|
          if @account_type.save
            format.html { redirect_to manage_accounts_path, notice: 'Account type was successfully created.' }
            format.json { render action: 'show', status: :created, location: @account_type }
          else
            format.html { render action: 'new' }
            format.json { render json: @account_type.errors, status: :unprocessable_entity }
          end
        end
    end

    def create
        @account = Account.new(account_params)

        respond_to do |format|
          if @account.save
            format.html { redirect_to manage_accounts_path, notice: 'Account type was successfully created.' }
            format.json { render action: 'show', status: :created, location: @account_type }
          else
            format.html { render action: 'new' }
            format.json { render json: @account.errors, status: :unprocessable_entity }
          end
        end
    end

    private
    # Never trust parameters from the scary internet, only allow the white list through.
    def account_type_params
      params.require(:account_type).permit(:name)
    end

    def account_params
      params.require(:account).permit(:name, :balance, :account_type_id)
    end
end
