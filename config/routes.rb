Rails.application.routes.draw do
  post 'check', to: 'check#check'
  root 'check#index'

  resources :cards
end
