Rails.application.routes.draw do
  devise_for :users
  resources :messages
  resources :groups do
    resources :messages
    resources :group_users
  end
  root to: 'main#index'
end
