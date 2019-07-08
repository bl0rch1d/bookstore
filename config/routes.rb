Rails.application.routes.draw do
  devise_for :customers, controllers: { omniauth_callbacks: 'customers/omniauth_callbacks' }
  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  resources :categories, only: [] do
    resources :books, only: :index
  end

  resources :reviews, only: :create

  resources :books, only: :show

  root 'home#index'
end
