class Stock < ActiveRecord::Base
    belongs_to :catagory
    has_many :sale_transactions

    after_initialize :set_defaults

    scope :low_stock, where( "qty <= min_stock" )

    def set_defaults
        self.qty ||= 0
        self.min_stock ||= 0
        self.cost_price ||= 0
        self.sell_price ||= 0
    end
end
