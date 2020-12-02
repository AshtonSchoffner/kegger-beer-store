Rails.application.routes.draw do
  devise_for :users
  resources :brewers, only: %i[index show]
  resources :beers, only: %i[index show] do
    collection do
      get "search"
    end
  end
  resources :categories, only: %i[index show]
  resources :subcategories, only: %i[show]
  resources :cart, only: %i[create destroy index update]
  resources :checkout, only: %i[index]
  resources :orders, only: %i[index]

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "beers#index"
end
