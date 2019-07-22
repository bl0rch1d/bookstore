Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  get 'settings',               to: 'users#index'

  put 'settings/addresses',     to: 'users#update_address'
  put 'settings/new_email',     to: 'users#update_email'
  put 'settings/new_password',  to: 'users#update_password'

  delete 'settings/destroy_account', to: 'users#destroy'

  resources :checkout

  devise_scope :user do
    get  'users/fast_new',    to: 'registrations#fast_new'
    post 'users/fast_create', to: 'registrations#fast_create'
  end

  post 'coupon/apply'

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
