class Catagory < ActiveRecord::Base
    has_many :stocks
    after_initialize :set_defaults

    def set_defaults
        self.order ||= Catagory.all.count + 1
    end
end
