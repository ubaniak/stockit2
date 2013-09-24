module ReportsHelper
    require 'csv'

    def daily_report_to_csv(date, 
                            sales, 
                            refunds,
                            invoices,
                            bills)

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
            csv << ["Account", "Amount", "Description"]
            bills.each do |bill|
                csv << [bill.account.name, bill.amount, bill.description]
            end


        end
    end
end
