Rails.application.routes.draw do
  devise_for :admins
  devise_for :users

  resources :comments
  resources :locations
  resources :pictures
  resources :venues

  get '/users' => 'users#index'
end
