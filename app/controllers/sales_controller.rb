class SalesController < ApplicationController

    def add_to_sale
    end

    def landing
        @catagories = Catagory.all
    end
end
