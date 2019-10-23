require 'sidekiq/web'

Rails.application.routes.draw do

  get 'auctions_imports/new'
  get 'auctions_imports/create'
  resources :auctions do
    post 'bids', to: 'bids#create'
  end
  resources :auctions_imports, only: [:new, :create]

  namespace :admin do
    resources :users
    resources :announcements
    resources :notifications
    resources :services

    root to: "users#index"
  end
  get '/home', to: 'home#index'
  get '/privacy', to: 'home#privacy'
  get '/terms', to: 'home#terms'
    authenticate :user, lambda { |u| u.admin? } do
      mount Sidekiq::Web => '/sidekiq'
    end


  resources :notifications, only: [:index]
  resources :announcements, only: [:index]
  # devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'auctions#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
