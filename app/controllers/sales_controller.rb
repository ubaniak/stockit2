class SalesController < ApplicationController
    before_filter :can_sell
    before_filter :authenticate_user!

    def new_sale
        @current_sales = SaleTransaction.find_all_by_user_id(current_user.id)
        @sale = Sale.new(sale_params)
        @sale.sale_transactions = @current_sales
        @sale.save

        redirect_to sales_landing_path, notice: "Sale Complete :)"
    end

    def refund
        @date = params[:date] ? Date.parse(params[:date], :format => "%Y-%m") : Date.today
        @sales = Sale.find_all_by_date(@date, false)
    end

    def refund_item
        Refund.refund_item(SaleTransaction.find(params[:id]), current_user)
        redirect_to refund_path
    end

    def add_to_sale
        stock = Stock.find(params[:id])
        transaction = SaleTransaction.find_by_stock_id_and_user_id(stock.id, current_user.id)
        if transaction.nil?
            transaction = SaleTransaction.new
            transaction.user_id = current_user.id
            transaction.stock = stock
        else
            transaction.qty += 1
        end
        transaction.save

        @current_sales = SaleTransaction.find_all_by_user_id(current_user.id)
    end

    def remove_from_sale
        transaction = SaleTransaction.find(params[:id])
        transaction.qty -= 1
        if transaction.qty <= 0
            transaction.destroy
        else
            transaction.save
        end

        @current_sales = SaleTransaction.find_all_by_user_id(current_user.id)
    end

    def landing
        @catagories = Catagory.all
        @sale = Sale.new
        @current_sales = SaleTransaction.find_all_by_user_id(current_user.id)
        @priority = Catagory.find_all_by_priority(true)
    end

    private

    def sale_params
      params.require(:sale).permit(:date, :account_id)
    end
end
