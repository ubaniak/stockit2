class SaleTransaction < ActiveRecord::Base
    belongs_to :sale 
    belongs_to :stock
    belongs_to :user

    before_save :set_defaults
    before_destroy :remove_sales

    def set_defaults
        self.qty ||= 1
        self.sell_price ||= self.stock.sell_price
    end

    def remove_sales
        self.stock.qty += self.qty
        self.sale.account.balance -= self.qty * self.sell_price
        self.sale.account.save

        if !self.sale.nil?
            if self.sale.sale_transactions.all.count == 1
                self.sale.destroy
            end
        end
    end
end
