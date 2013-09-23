class Stock < ActiveRecord::Base
    belongs_to :catagory
    has_many :sale_transactions
    has_many :change_stock_qtys

    after_initialize :set_defaults


    def self.low_stocks
        self.where( "qty <= min_stock" )
    end

    def low_stock?
        self.qty <= self.min_stock 
    end

    def set_defaults
        self.qty ||= 0
        self.min_stock ||= 0
        self.cost_price ||= 0
        self.sell_price ||= 0
    end
end
