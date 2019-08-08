require 'sidekiq/web'

Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    confirmations: 'users/confirmations',
    registrations: 'users/registrations'
  }

  devise_scope :user do
    get  'users/fast_new',    to: 'users/registrations#fast_new'
    post 'users/fast_create', to: 'users/registrations#fast_create'
  end

  resources :checkout_steps, only: %i[index show update]

  resource :addresses, only: %i[edit update] do
    patch :edit, on: :collection, action: :update
  end

  resource :coupon, only: :create, action: :apply

  resources :order_items, only: %i[create update destroy]

  resources :cart, only: :index

  resources :orders, only: %i[index show]

  resources :categories, only: [] do
    resources :books, only: :index
  end

  resources :reviews, only: :create
  
  resources :books, only: %i[index show]

  root 'pages#home'
end
