Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  devise_for :customers, controllers: { omniauth_callbacks: 'customers/omniauth_callbacks' }
  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  # === TODO: Refactor ===

  get 'settings', to: 'settings#index'

  put 'settings/addresses',     to: 'customers#update_address'
  put 'settings/new_email',     to: 'customers#update_email'
  put 'settings/new_password',  to: 'customers#update_password'

  delete 'settings/destroy_account', to: 'customers#destroy'

  resources :checkout

  devise_scope :customer do
    get  'customers/fast_new',    to: 'registrations#fast_new'
    post 'customers/fast_create', to: 'registrations#fast_create'
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
