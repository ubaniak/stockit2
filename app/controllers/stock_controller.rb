class StockController < ApplicationController

    before_filter :authenticate_user!
    before_filter :can_manage, :only => [:create_catagory, :create, :find_stock, :index, :edit]
    before_filter :can_sell, :only => [:find_stock]

    def index
        @stocks = Stock.all
    end

    def edit
        @stock = Stock.find(params[:id])
    end

    def update
        @stock = Stock.find(params[:id])
        @stock.update(:name => params[:name], 
                      :catagory_id => params[:catagory_id], 
                      :cost_price => params[:cost_price], 
                      :sell_price => params[:sell_price], 
                      :min_stock => params[:min_stock])

        redirect_to list_stocks_path, notice: "Stock successfully updated"
    end

    def find_stock
        @catagory = Catagory.find(params[:id])
        @options = params[:options]
    end

    def change_stock_qty
        @stock = Stock.find(params[:id])
    end

    def update_qty
        @change_qty = ChangeStockQty.new
        @change_qty.stock_id = params[:id]
        @change_qty.qty = params[:qty]
        @change_qty.reason = params[:reason]
        @change_qty.user_id = current_user.id

        @change_qty.save
        


        redirect_to list_stocks_path
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
