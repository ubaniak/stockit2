class Stock < ActiveRecord::Base
    belongs_to :catagory

    after_initialize :set_defaults

    def set_defaults
        self.qty ||= 0
        self.cost_price ||= 0
        self.sell_price ||= 0
    end
end
