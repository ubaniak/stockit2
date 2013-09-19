class InvoiceItem < ActiveRecord::Base
    belongs_to :user
    belongs_to :stock
    belongs_to :invoice

    after_destroy :untransfer

    def update_stock
        self.stock.qty += self.qty
        self.stock.cost_price = self.cost_price unless self.stock.cost_price == self.cost_price
        self.stock.sell_price = self.sell_price unless self.stock.sell_price == self.sell_price
        self.stock.save
    end

    def untransfer
        self.stock.qty -= self.qty
        self.stock.save
    end
end
