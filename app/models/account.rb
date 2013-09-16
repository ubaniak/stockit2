class Account < ActiveRecord::Base
    belongs_to :account_type

    after_initialize :set_defaults

    def set_defaults
        self.balance ||= 0
    end
end
