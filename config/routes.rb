GameStatus::Application.routes.draw do

  root :to => 'home#index'
  
  devise_for :users, controllers: { registrations: 'registrations' }

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    delete 'logout', to: 'devise/sessions#destroy'
    get 'register', to: 'devise/registrations#new'
  end

  resources :games
  resources :consoles
  resources :play_times

  get 'users/:id' => 'users#show', :as => 'user'
  
  get 'games/:id/add_remove' => 'games#add_remove', :as => 'add_remove_game'
  
  get 'consoles/:id/add_remove' => 'consoles#add_remove', :as => 'add_remove_console'
  
  get 'friends' => 'users#index', :as => 'friends'
  get 'friendship/req/:id' => 'friendships#req', :as => 'req_friendship'
  get 'friendship/accept/:id' => 'friendships#accept', :as => 'accept_friendship'
  get 'friendship/reject/:id' => 'friendships#reject', :as => 'reject_friendship'

  get 'play' => 'play_times#new', :as => 'play'
  get 'play/:id/attend' => 'play_times#attend', :as => 'attend'
  get 'play/:id/unattend' => 'play_times#unattend', :as => 'unattend'

end
