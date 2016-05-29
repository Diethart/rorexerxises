Rails.application.routes.draw do
  get  "oauth/callback"  => "home/oauths#callback"
  get  "oauth/:provider" => "home/oauths#oauth",  :as => :auth_at_provider
  root "users#index"

  resources :users

  scope module: "dashboard" do
    resources :cards
    resources :decks, except: [:show]
    resources :admins, only:  [:index]
    get  'check',  to: 'check#index'
    post 'check',  to: 'check#check'
    post 'photos', to: 'cards#photos'
  end

  scope module: "home" do
    resources :sessions, only: [:create]
  end

  get    'login'  => 'home/sessions#new',                  :as => :login
  delete 'logout' => 'dashboard/sessions#destroy',         :as => :logout
  post   'locale' => 'dashboard/sessions#set_user_locale', :as => :locale


end
