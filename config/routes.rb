Rails.application.routes.draw do
  resources :blogposts
  resources :active_members
  resources :comments
  resources :events
  resources :locations
  resources :pictures
  resources :venues
  resources :contents, only: [:index, :show]

  devise_for :admins
  devise_for :users

  get '/' => redirect('/home')
  get '/about' => 'about#show'
  get '/faciliation' => 'application#faciliation'
  get '/home' => 'home#show'
  get '/imprint' => 'application#imprint'
  get '/guideline' => 'application#guideline'

  get '/users' => 'users#index'
  get '/users/:id' => 'users#show', as: 'user'

  get '/styleguide' => 'application#styleguide'
end
