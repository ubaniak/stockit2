class Invoice < ActiveRecord::Base
    belongs_to :account
    has_many :invoice_items

    after_save :transfer

    def transfer
        total = 0
        self.invoice_items.each do |ii|
            ii.user_id = nil
            ii.update_stock
            ii.save
            total += ii.cost_price * ii.qty
        end
        self.account.balance += total
    end
end
