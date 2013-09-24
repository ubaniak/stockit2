class Sale < ActiveRecord::Base
    has_many :sale_transactions
    belongs_to :account
    belongs_to :users

    after_save :transfer
    after_save :set_default_number
    before_destroy :untransfer
    after_initialize :set_defaults 

    def set_defaults
        self.date ||= Date.today
    end


    def self.date_range(sd, ed)
        self.where("date between ? and ?", sd, ed).order("date")
    end

    def calc_total
        total = {
            :sales => 0,
            :cost_price => 0,
            :sell_price => 0,
        }
        self.sale_transactions.each do |st|
            total[:sales] = st.sell_price * st.qty
            if not st.refunded
                total[:cost_price] = st.stock.cost_price * st.qty
                total[:sell_price] = st.sell_price * st.qty
            end
        end
        return total
    end

    def transfer
        total = 0
        self.sale_transactions.each do |st|
            total += st.sell_price * st.qty
            st.user_id = nil
            st.save

            st.stock.qty -= st.qty
            st.stock.save
        end
        self.account.balance += total
        self.account.save
    end

    def untransfer
    end

    def set_default_number
        self.number ||= self.id
    end
end
