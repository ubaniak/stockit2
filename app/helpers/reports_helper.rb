module ReportsHelper
    require 'csv'

    def profit_and_loss_to_csv(date, total, account_types)
        CSV.generate do |csv|
            csv << ["Profit and loss report for:", date.to_s]

            csv << ["Number of sales", total[:number_of_sales]]
            csv << ["Number of refunds", total[:number_of_refunds]]

            csv << []
            csv << ["Total Amount"]
            csv << ["Sales:", total[:sales]]
            csv << ["Refunds:", total[:refunds]]

            csv << []
            csv << ["Sold items"]
            csv << ["Cost Price", total[:cost_price]]
            csv << ["Sell Price", total[:sell_price]]
            csv << ["Gross Profit", total[:sell_price] - total[:cost_price]]

            csv << []
            csv << ["Account Transfers"]
            csv << ["Number of account transfers", total[:number_of_account_transfers]]
            csv << ["Number of payments", total[:number_of_payments]]
            csv << ["Total", total[:payments]]

            csv << []
            csv << ["Amounts transfered to:"]
            account_types.each do |at|
                csv << [at.name, total[at.name]]
            end
            csv << ["Total transfers", total[:transfers]]

            csv << []
            csv << ["Profits less payments", total[:sell_price] - total[:cost_price] - total[:payments]]
        end
    end

    def daily_report_to_csv(date, 
                            sales, 
                            refunds,
                            invoices,
                            bills,
                            account_transfers)

        CSV.generate do |csv|
            csv << ["Daily report for:", date.to_s]
            
            csv << ["Sales"]
            csv << ["Account", "Item", "qty", "sell price", "refunded", "total"]
            total = 0
            sales.each do |sale|
                sale.sale_transactions.each do |st|
                    csv << [sale.account.name, st.stock.name, st.qty, st.sell_price, st.refunded, st.qty * st.sell_price]
                    total += st.qty * st.sell_price
                end
            end
            csv << ["Total:","","","","", total]
            csv << []

            csv << ["Refunds"]
            csv << ["Sale date", "Item", "qty", "Sell price", "total"]
            total = 0
            refunds.each do |refund|
                csv << [refund.sale_date, refund.stock.name, refund.qty, refund.sell_price, refund.qty * refund.sell_price]
                total += refund.qty * refund.sell_price
            end
            csv << ["Total:","","","", total]
            csv << []

            csv << ["Invoices"]
            csv << ["Account", "Invoice #", "Item", "Qty", "Cost Price", "Sell Price", "Total"]

            invoices.each do |invoice|
                total = 0
                invoice.invoice_items.each do |invoice_item|
                    csv << [invoice.account.name,invoice.number, invoice_item.stock.name, invoice_item.qty, invoice_item.cost_price, invoice_item.sell_price, invoice_item.qty * invoice_item.cost_price]
                    total += invoice_item.qty * invoice_item.cost_price
                end
                csv << ["Total:","","","","","",total]
            end
            csv << []

            csv << ["Bills"]
            csv << ["Account", "Description", "Amount"]
            bills.each do |bill|
                csv << [bill.account.name, bill.description, bill.amount]
            end
            csv << []

            csv << ["Account transfers"]
            csv << ["From", "To", "Reason", "Payment", "Amount"]
            account_transfers.each do |at|
                csv << [ at.from_account.name, at.to_account.name, at.reason, at.payment, at.amount]
            end
        end
    end
end
