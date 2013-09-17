class Sale < ActiveRecord::Base
    has_many :sale_transactions
    belongs_to :account
    belongs_to :users
    after_save :set_default_number

    def set_default_number
        self.number ||= self.id
    end
end
