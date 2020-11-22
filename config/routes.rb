Rails.application.routes.draw do
  resources :brewers, only: %i[index show]
  resources :beers, only: %i[index show]
  resources :categories, only: %i[index show]
  resources :subcategories, only: %i[show]
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "beers#index"
end
