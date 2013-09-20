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
        SaleTransaction.add_to_sale(params[:id], current_user.id)
        @current_sales = SaleTransaction.find_all_by_user_id(current_user.id)
    end

    def remove_from_sale
        SaleTransaction.remove_from_sale(params[:id])

        @current_sales = SaleTransaction.find_all_by_user_id(current_user.id)
        redirect_to sales_landing_path
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
