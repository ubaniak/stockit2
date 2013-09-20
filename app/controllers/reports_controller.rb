class ReportsController < ApplicationController
    before_filter :can_report
    before_filter :authenticate_user!

    def landing
    end

    def daily
        @date = params[:date] ? Date.parse(params["date"]) : Date.today

        @sales = Sale.find_all_by_date(@date)
        @refunds = Refund.find_all_by_date(@date)
        @invoices = Invoice.find_all_by_date(@date)
        @bills = Bill.find_all_by_date(@date)
        @account_transfers = AccountTransfer.find_all_by_date(@date)
    end

    def stock 
        @catagories = Catagory.all
    end
end
