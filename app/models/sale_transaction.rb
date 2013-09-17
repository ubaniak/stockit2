class SaleTransaction < ActiveRecord::Base
    belongs_to :sale 
    belongs_to :stock
    belongs_to :user

    before_save :set_defaults

    def set_defaults
        self.qty ||= 1
        self.sell_price ||= self.stock.sell_price
    end
end
