Rails.application.routes.draw do
  resources :albums
  resources :users, only: [:new, :create]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'welcome', to: 'sessions#welcome'

  root to: 'sessions#new'
end
