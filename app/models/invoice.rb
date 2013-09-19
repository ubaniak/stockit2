class Invoice < ActiveRecord::Base
    belongs_to :account
    has_many :invoice_items

    after_save :transfer

    def transfer
        self.invoice_items.each do |ii|
            ii.user_id = nil
            ii.update_stock
            ii.save
        end
    end
end
