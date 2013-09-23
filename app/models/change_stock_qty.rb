class ChangeStockQty < ActiveRecord::Base
    belongs_to :stock
    belongs_to :user

    after_initialize :set_defaults
    after_save :transfer

    def set_defaults
        self.date = Date.today
    end

    def transfer
        self.old_qty = self.stock.qty
        self.stock.qty = qty
        self.stock.save
    end
end
