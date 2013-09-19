class Refund < ActiveRecord::Base
    belongs_to :user
    belongs_to :stock

    def self.refund_item(item, user)
        refund = self.new
        refund.date = Date.today
        refund.user = user
        refund.sale_date = item.sale.date
        refund.stock = item.stock
        refund.qty = item.qty
        refund.sell_price = item.sell_price

        refund.save
        item.destroy
    end
end
