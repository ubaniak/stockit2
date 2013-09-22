class StockController < ApplicationController

    before_filter :authenticate_user!
    before_filter :can_manage, :only => [:create_catagory, :create, :find_stock]
    before_filter :can_sell, :only => [:find_stock]

    def find_stock
        @catagory = Catagory.find(params[:id])
        @options = params[:options]
    end

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
      params.require(:catagory).permit(:name, :display_order, :priority)
    end

    def stock_params
      params.require(:stock).permit(:catagory_id, :name, :qty, :cost_price, :sell_price, :min_stock)
    end
end
