Rails.application.routes.draw do
  get  "oauth/callback"  => "oauths#callback"
  get  "oauth/:provider" => "oauths#oauth",  :as => :auth_at_provider

  get  'check', to: 'check#index'
  post 'check', to: 'check#check'
  root 'users#index'

  resources :cards
  resources :sessions, only:   [:create]
  resources :users
  resources :decks,    except: [:show]

  get    'login'  => 'sessions#new',             :as => :login
  delete 'logout' => 'sessions#destroy',         :as => :logout
  post   'locale' => 'sessions#set_user_locale', :as => :locale


end
