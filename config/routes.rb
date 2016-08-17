Rails.application.routes.draw do
  resources :pictures
  resources :comments
  devise_for :admins
  devise_for :users
end
