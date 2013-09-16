class StockController < ApplicationController
    def create_catagory
        @catagory = Catagory.new(catagory_params)

        respond_to do |format|
          if @catagory.save
            format.html { redirect_to manage_stocks_path, notice: 'Catagory was successfully created.' }
            format.json { render action: 'show', status: :created, location: @catagory }
          else
            format.html { render action: 'new' }
            format.json { render json: @catagory.errors, status: :unprocessable_entity }
          end
        end
    end

    def create 
        @stock = Stock.new(stock_params)

        respond_to do |format|
          if @stock.save
            format.html { redirect_to manage_stocks_path, notice: 'Stock was successfully created.' }
            format.json { render action: 'show', status: :created, location: @stock }
          else
            format.html { render action: 'new' }
            format.json { render json: @stock.errors, status: :unprocessable_entity }
          end
        end
    end

    private
    def catagory_params
      params.require(:catagory).permit(:name)
    end

    def stock_params
      params.require(:stock).permit(:catagory_id, :name, :qty, :cost_price, :sell_price)
    end
end
