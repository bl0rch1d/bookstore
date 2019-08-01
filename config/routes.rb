Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener'
  
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    confirmations: 'confirmations'
  }

  resources :checkout, only: %i[index show update]

  devise_scope :user do
    get  'users/fast_new',          to: 'registrations#fast_new'
    post 'users/fast_create',       to: 'registrations#fast_create'
    
    get 'users/privacy'
    
    get 'users/addresses'
    patch 'users/addresses',        to: 'users#update_address'
    
    patch 'users/update_email'
    patch 'users/update_password'
    
    delete 'users/destroy'
  end

  resource :coupon, only: :create, action: :apply

  resources :order_items, only: %i[create update destroy]
  resources :cart, only: :index

  resources :orders, only: %i[index show]

  resources :categories, only: [] do
    resources :books, only: :index
  end

  resources :reviews, only: :create

  resources :books, only: :show

  root 'home#index'
end
