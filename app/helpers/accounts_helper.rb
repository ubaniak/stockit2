module AccountsHelper

    def default_sales_account
        if not is_default_sales_account_set?
            redirect_to root_path, notice: "There is no default sales account set. Please contact your administrator"
        end
    end

    def is_default_sales_account_set?
        not Account.find_by_default_sales(true).nil?
    end
    
end
