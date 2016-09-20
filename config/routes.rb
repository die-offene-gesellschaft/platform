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
  get '/contact' => 'application#contact'
  get '/faciliation' => 'application#faciliation'
  get '/imprint' => 'application#imprint'
  get '/privacy' => 'application#privacy'
  get '/guideline' => 'application#guideline'

  get '/home' => 'home#show'

  get '/users' => 'users#index'
  get '/users/:id' => 'users#show', as: 'user'

  get '/participate' => 'participate#show'

  get '/styleguide' => 'application#styleguide'
end
