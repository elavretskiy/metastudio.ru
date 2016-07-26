Rails.application.routes.draw do
  devise_for :users

  root 'uploads#index'

  resources :uploads, only: [:index, :create]
end
