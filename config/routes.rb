GameStatus::Application.routes.draw do

  root :to => 'home#index'
  
  devise_for :users

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    delete 'logout', to: 'devise/sessions#destroy'
  end

  resources :games
  resources :consoles
  resources :play_times

  get 'users/:id' => 'users#show', :as => 'user'
  get 'users' => 'users#index', :as => 'users'
  
  get 'games/:id/add' => 'games#add', :as => 'add_game'
  get 'games/:id/remove' => 'games#remove', :as => 'remove_game'
  
  get 'consoles/:id/add' => 'consoles#add', :as => 'add_console'
  get 'consoles/:id/remove' => 'consoles#remove', :as => 'remove_console'
  
  get 'friends' => 'friendships#index', :as => 'friends'
  get 'friendship/req/:id' => 'friendships#req', :as => 'req_friendship'
  get 'friendship/accept/:id' => 'friendships#accept', :as => 'accept_friendship'
  get 'friendship/reject/:id' => 'friendships#reject', :as => 'reject_friendship'

  get 'play' => 'play_times#new', :as => 'play'

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

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
