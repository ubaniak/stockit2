class Bill < ActiveRecord::Base
    belongs_to :account

    after_save :transfer
    before_destroy :untransfer

    def transfer
        self.account.balance += self.amount
        self.account.save
    end

    def untransfer
        self.account.balance -= self.amount
        self.account.save
    end
end
