class AccountTransfersController < ApplicationController
    def create
        @account_transfer = AccountTransfer.new(account_transfer_params)

        respond_to do |format|
          if @account_transfer.save
            format.html { redirect_to manage_account_transfer_path, notice: 'Account transfer was successfully created.' }
            format.json { render action: 'show', status: :created, location: @account_transfer }
          else
            format.html { render action: 'new' }
            format.json { render json: @account_transfer.errors, status: :unprocessable_entity }
          end
        end
    end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def account_transfer_params
      params.require(:account_transfer).permit(:from, :to, :amount, :reason, :date, :payment)
    end
end
