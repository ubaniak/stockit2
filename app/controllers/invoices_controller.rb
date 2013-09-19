class InvoicesController < ApplicationController

    def create_invoice_item
        @invoice_item = InvoiceItem.new(invoice_item_params)
        @invoice_item.user = current_user
        @invoice_item.save
        redirect_to manage_invoice_path
    end

    def create
        @invoice = Invoice.new(invoice_params)
        @invoice_items = InvoiceItem.find_all_by_user_id(current_user.id)
        @invoice.invoice_items = @invoice_items
        @invoice.save
        redirect_to manage_invoice_path
    end

    private
    def invoice_params
      params.require(:invoice).permit(:date, :account_id)
    end
    def invoice_item_params
      params.require(:invoice_item).permit(:stock_id, :qty, :cost_price, :sell_price)
    end
end
