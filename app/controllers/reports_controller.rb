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

    def profit_and_loss
        @date = params[:date] ? Date.parse(params["date"]) : Date.today
        @sales = Sale.find_all_by_date(@date)
        @refunds = Refund.find_all_by_date(@date)
        @account_transfers = AccountTransfer.find_all_by_date(@date)
        @account_types = AccountType.all

        @total = {
            :number_of_sales => @sales.count,
            :number_of_refunds => @refunds.count,
            :number_of_account_transfers => @account_transfers.count,
            :number_of_payments => 0,
            :payments => 0,
            :sales => 0,
            :cost_price => 0,
            :sell_price => 0,
            :refunds => 0,
            :transfers => 0,
        }

        @account_types.each do |at|
            @total[at.name] = 0
        end

        @sales.each do |sale|
            sale_total = sale.calc_total
            @total[:sales] += sale_total[:sales]
            @total[:cost_price] += sale_total[:cost_price]
            @total[:sell_price] += sale_total[:sell_price]
        end

        @refunds.each do |refund|
            @total[:refunds] = refund.qty * refund.sell_price
        end

        @account_transfers.each do |ac|
            if ac.payment
                @total[:number_of_payments] += 1
                @total[:payments] += ac.amount
            end
            @total[ac.to_account.account_type.name] += ac.amount
            @total[:transfers] += ac.amount
        end
    end

    def stock_take_cards
        @catagories = Catagory.all
    end

    def low_stock
        @stocks = Stock.low_stocks
    end
end
