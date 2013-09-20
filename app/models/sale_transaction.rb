class SaleTransaction < ActiveRecord::Base
    belongs_to :sale 
    belongs_to :stock
    belongs_to :user

    before_save :set_defaults

    def set_defaults
        self.qty ||= 1
        self.sell_price ||= self.stock.sell_price
    end

    def self.add_to_sale(stock_id, user_id)
        transaction = SaleTransaction.find_by_stock_id_and_user_id(stock_id, user_id)
        if transaction.nil?
            transaction = self.new
            transaction.user_id = user_id
            transaction.stock_id = stock_id
        else
            transaction.qty += 1
        end
        transaction.save
    end

    def self.remove_from_sale(id)
        transaction = SaleTransaction.find(id)
        transaction.qty -= 1
        if transaction.qty <= 0
            transaction.destroy
        else
            transaction.save
        end
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
