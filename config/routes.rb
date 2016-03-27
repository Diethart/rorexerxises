Rails.application.routes.draw do
  get  'check', to: 'check#index'
  post 'check', to: 'check#check'
  root 'users#index'

  resources :cards
  resources :sessions, only: [:create]
  resources :users

  get 'login' => 'sessions#new', :as => :login
  delete 'logout' => 'sessions#destroy', :as => :logout
end
