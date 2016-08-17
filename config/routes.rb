Rails.application.routes.draw do
  resources :locations
  resources :pictures
  resources :comments
  devise_for :admins
  devise_for :users
end
