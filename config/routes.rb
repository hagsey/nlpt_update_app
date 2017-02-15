Rails.application.routes.draw do

  devise_for :users
  root to: 'static_pages#home'

  get '/coaches', to: 'users#index'
  get '/coaches/:id', to: 'users#show', :as => :coach
  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user
  get '/updates', to: 'updates#index'
  # resources :coaches, only: [:index, :show], controller: :users
  
  post '/search', to: 'client_search#index'
  resources :clients do 
    resources :updates 
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
