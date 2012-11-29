Brise::Application.routes.draw do
  resources :company_products

  resources :helps

  resources :companies

  resources :reviews

  resources :events
  
  resources :comments

  resources :ads, only: [ :create, :destroy, :edit, :update ] do
    resources :brand
    resources :product 
    resources :comments
  end

  resources :products do
    resources :brands_products
    resources :brands
    resources :reviews
  end

  resources :relationships, only: [:create, :destroy]
  
  constraints lambda { |r| r.env[ "devise.mapping" ] = Devise.mappings[:user] } do
    devise_for :users, :controllers => {:sessions => 'devise/sessions', :registrations => 'users'} do
      get "/login", :to => "devise/sessions#new", :as => :login
      get "/signup", :to => "devise/registration#new", :as => :signup
      get "/logout", :to => "devise/sessions#destroy", :as => :logout
    end
    resources :users do
      member do
        get :following, :followers, :following_ads, :show, :home
      end
      resources :companies
    end
    root :to => "users#home"
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
  match '/home', to: 'users#home'
end
