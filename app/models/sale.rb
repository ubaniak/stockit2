class Sale < ActiveRecord::Base
    has_many :sale_transactions
    belongs_to :account
    belongs_to :users

    after_save :transfer
    after_save :set_default_number
    before_destroy :untransfer

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
