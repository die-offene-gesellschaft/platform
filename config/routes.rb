Rails.application.routes.draw do
  resources :venues
  resources :locations
  resources :pictures
  resources :comments
  devise_for :admins
  devise_for :users
end
