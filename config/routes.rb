Rails.application.routes.draw do
  resources :cities
  resources :jobs
  resources :categories
  root to: 'visitors#index'
  devise_for :users
  resources :users

  get '/city-districts/index', action: 'index', controller: 'city_districts'
end
