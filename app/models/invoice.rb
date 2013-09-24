class Invoice < ActiveRecord::Base
    belongs_to :account
    has_many :invoice_items

    after_save :transfer

    def self.date_range(sd, ed)
        self.where("date between ? and ?", sd, ed).order("date")
    end

    def self.search(search)
        if search
            Invoice.joins(:account).where("name LIKE ?", "%#{search}%")
        else
            return self.all
        end
    end

    def transfer
        total = 0
        self.invoice_items.each do |ii|
            ii.user_id = nil
            ii.update_stock
            ii.save
            total += ii.cost_price * ii.qty
        end
        self.account.balance += total
        self.account.save
    end
end
