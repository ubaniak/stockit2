class Sale < ActiveRecord::Base
    after_save :set_default_number

    def set_default_number
        self.number ||= self.id
    end
end
