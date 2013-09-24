class AccountTransfer < ActiveRecord::Base
    before_save :transfer
    after_destroy :untransfer

    def self.date_range(sd, ed)
        self.where("date between ? and ?", sd, ed)
    end

    def from_account
        Account.find(self.from)
    end

    def to_account
        Account.find(self.to)
    end

    def transfer
        from = Account.find(self.from)
        to = Account.find(self.to)

        from.balance -= self.amount
        if self.payment
            to.balance -= self.amount
        else
            to.balance += self.amount
        end

        from.save
        to.save
    end

    def untransfer
        from = self.from_account
        to = self.to_account

        from.balance += self.amount
        to.balance -= self.amount

        from.save
        to.save
    end
end
