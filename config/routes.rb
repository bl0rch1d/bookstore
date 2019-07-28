Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    confirmations: 'confirmations'
  }

  # === TODO: Refactor ===
  get 'settings',               to: 'users#index'

  put 'settings/addresses',     to: 'users#update_address'
  put 'settings/new_email',     to: 'users#update_email'
  put 'settings/new_password',  to: 'users#update_password'

  delete 'settings/destroy_account', to: 'users#destroy'

  resources :checkout, only: %i[index show update]

  devise_scope :user do
    get  'users/fast_new',          to: 'registrations#fast_new'
    post 'users/fast_create',       to: 'registrations#fast_create'

    # get 'users/addresses',          to: 'users#addresses'
    # patch 'users/update_addresses', to: 'users#update_addresses'

    # get 'users/privacy',            to: 'users#privacy'
    # patch 'users/update_email',     to: 'users#update_email'
    # patch 'users/new_password',     to: 'users#update_password'

    # delete 'users/destroy_account', to: 'users#destroy'
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
