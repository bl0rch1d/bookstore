Rails.application.routes.draw do
  devise_for :customers, controllers: { omniauth_callbacks: 'customers/omniauth_callbacks' }
  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  # get '/shop', to: 'books#index', as: :books

  resources :categories, only: [] do
    resources :books, only: :index
  end

  resources :books, only: :show

  root 'home#index'
end
