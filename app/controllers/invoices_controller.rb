class InvoicesController < ApplicationController

    def create_invoice_item
    end

    def create
    end

    private
    def invoice_params
      params.require(:invoice).permit(:date, :account_id)
    end
    def invoice_item_params
      params.require(:invoice_item).permit(:stock_id, :qty, :cost_price, :sell_price, :user_id)
    end
end
