Stockit2::Application.routes.draw do

  devise_for :users
    post "account_types" => "accounts#create_account_type"
    post "catagories" => "stock#create_catagory"
    post "stocks" => "stock#create"
    post "account_transfers" => "account_transfers#create"
    post "bills" => "bills#create"
    post "users" => "users#create"
    post "sales" => "sales#new_sale"
    post "invoices" => "invoices#create"
    post "invoice_items" => "invoices#create_invoice_item"

    # Manage
  get "manage_users" => "manage#users"
  get "manage_invoice" => "manage#invoice"
  get "manage_accounts" => "manage#accounts"
  get "manage_stocks" => "manage#stocks"
  get "manage_account_transfer" => "manage#account_transfer"
  get "manage_bills" => "manage#bills"
  get "manage_landing" => "manage#landing"
  get "create_dafault_sales_account" => "manage#create_default_sales_account"


    #accounts
  get "accounts" => "accounts#index"
  get "edit_account" => "accounts#edit"
  post "update_account" => "accounts#update"

    # Sale
  get "sales_landing" => "sales#landing"
  get "add_to_sale" => "sales#add_to_sale"
  get "remove_from_sale" => "sales#remove_from_sale"
  get "refund" => "sales#refund"
  get "refund_item" => "sales#refund_item"
  get "void_sale" => "sales#void_sale"


    # Stock
  get "find_stock" => "stock#find_stock"
  root "pages#home"
  get "list_stocks" => "stock#index"
  get "edit_stock" => "stock#edit"
  post "update_stock" => "stock#update"
  get "change_stock_qty" => "stock#change_stock_qty"
  post "update_qty" => "stock#update_qty"

    # Reports
  get "reports_landing" => "reports#landing"
  get "daily_report" => "reports#daily"
  get "stock_report" => "reports#stock"
  get "profit_and_loss_report" => "reports#profit_and_loss"
  get "stock_take_cards" => "reports#stock_take_cards"
  get "low_stock_report" => "reports#low_stock"

    # Users
  get "edit_user" => "users#edit"
  post "update_user" => "users#update"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
