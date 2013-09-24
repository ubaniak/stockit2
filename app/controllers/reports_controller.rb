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

        respond_to do |format|
            format.html
            format.csv { render text: daily_report_to_csv(@date, @sales, @refunds, @invoices, @bills, @account_transfers) }
            format.xls { render text: daily_report_to_csv(@date, @sales, @refunds, @invoices, @bills, @account_transfers) }
        end
    end

    def stock 
        @catagories = Catagory.all
        respond_to do |format|
            format.html
            format.csv { render text: cat_stock_to_csv(@catagories) }
            format.xls { render text: cat_stock_to_csv(@catagories) }
        end
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

        respond_to do |format|
            format.html
            format.csv { render text: profit_and_loss_to_csv([@date], @total, @account_types) }
            format.xls { render text: profit_and_loss_to_csv([@date], @total, @account_types) }
        end
    end

    def stock_take_cards
        @catagories = Catagory.all
        respond_to do |format|
            format.html
            format.csv { render text: stock_take_cards_to_csv(@catagories) }
            format.xls { render text: stock_take_cards_to_csv(@catagories) }
        end
    end

    def low_stock
        @stocks = Stock.low_stocks
        respond_to do |format|
            format.html
            format.csv { render text: stock_to_csv(@stocks) }
        end
    end

    def range_profit_and_loss
        @dates = get_date_range

        @sales = Sale.date_range(*@dates)
        @refunds = Refund.date_range(*@dates)
        @account_transfers = AccountTransfer.date_range(*@dates)
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

        respond_to do |format|
            format.html
            format.csv { render text: profit_and_loss_to_csv(@dates, @total, @account_types) }
            format.xls { render text: profit_and_loss_to_csv(@dates, @total, @account_types) }
        end
    end

    def range_sales
        @dates = get_date_range
        @sales = Sale.date_range(*@dates)
        respond_to do |format|
            format.html
            format.csv { render text: sales_to_csv(@sales) }
            format.xls { render text: sales_to_csv(@sales) }
        end
    end

    def stock_change
        @dates = get_date_range
        @change_stock_qty = ChangeStockQty.date_range(*@dates)
        respond_to do |format|
            format.html
            format.csv { render text: change_stock_qty_to_csv(@change_stock_qty) }
            format.xls { render text: change_stock_qty_to_csv(@change_stock_qty) }
        end
    end

    def invoices
        @dates = get_date_range
        if not params[:search].nil?
            @search = params[:search]
            @invoices = Invoice.search(params[:search])
        else
            @invoices = Invoice.date_range(*@dates)
        end

        respond_to do |format|
            format.html
            format.csv { render text: invoice_to_csv(@invoices) }
            format.xls { render text: invoice_to_csv(@invoices) }
        end
    end

    private
    def get_date_range
        @start_date = params[:start_date] ? Date.parse(params[:start_date]) : Date.today
        @end_date = params[:end_date] ? Date.parse(params[:end_date]) : Date.today
        return [@start_date, @end_date]
    end
end
