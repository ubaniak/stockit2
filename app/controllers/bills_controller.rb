class BillsController < ApplicationController
    before_filter :authenticate_user!
    before_filter :can_manage

    def create
        
        @bill = Bill.new(bill_params)
        respond_to do |format|
          if @bill.save
            format.html { redirect_to manage_bills_path, notice: 'Bill was successfully created.' }
            format.json { render action: 'show', status: :created, location: @bill }
          else
            format.html { render action: 'new' }
            format.json { render json: @bill.errors, status: :unprocessable_entity }
          end
        end
    end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def bill_params
      params.require(:bill).permit(:account_id, :amount, :description, :date)
    end
end
