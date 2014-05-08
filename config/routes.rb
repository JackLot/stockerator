Stockerator::Application.routes.draw do

  resources :individual_portfolio_investments

  resources :individual_portfolio_invesetments

  resources :fund_company_investments

  resources :individual_company_investments

  resources :individuals

  resources :portfolios

  resources :investables

  resources :quotes

  resources :companies

  resources :investments

  resources :comparison

  get "investments/new"
  post "investments/manual_input" => 'investments#manual_input'
  post "investments/process_csv_file" => 'investments#process_csv_file'
  post "investments/delete_all" => 'investments#delete_all'

  post "companies/search" => 'companies#search'
  post "individuals/search" => 'individuals#search'
  post "portfolios/search" => 'portfolios#search'

  get "comparison/new"
  post "comparison/show_comparison" => 'comparison#show_comparison'
  post "comparison/get_csv" => 'comparison#get_csv'


  get "welcome/index"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

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
