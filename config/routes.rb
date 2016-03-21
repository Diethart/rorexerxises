Rails.application.routes.draw do
  get 'check/index'
  post 'check/index', as: 'check_card', to: 'check#check'
  root 'check#index'

  resources :cards
end
