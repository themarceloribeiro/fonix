Rails.application.routes.draw do
  devise_for :users
  resources :messages
  root to: 'main#index'
end
