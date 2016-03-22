Rails.application.routes.draw do
  get 'check', to: 'check#index'
  post 'check', to: 'check#check'
  root 'check#index'

  resources :cards
end
