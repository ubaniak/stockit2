class Account < ActiveRecord::Base
    belongs_to :account_type
    has_many :bills
    has_many :sales
    has_many :invoices

    after_initialize :set_defaults

    def set_defaults
        self.balance ||= 0
    end
end
