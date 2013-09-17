class SaleTransaction < ActiveRecord::Base
    belongs_to :sale 
    belongs_to :stock
    belongs_to :user
end
