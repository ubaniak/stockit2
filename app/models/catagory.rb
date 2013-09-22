class Catagory < ActiveRecord::Base
    has_many :stocks
    after_initialize :set_defaults

    default_scope :order => "display_order"

    def set_defaults
        self.display_order ||= Catagory.all.count + 1
    end
end
