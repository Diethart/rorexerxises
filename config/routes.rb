Rails.application.routes.draw do
  get 'welcome/index'
  get 'cards/show' => 'cards_controller#show'
  root 'welcome#index'
end
