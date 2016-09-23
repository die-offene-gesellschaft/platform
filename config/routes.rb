Rails.application.routes.draw do
  resources :blogposts, only: [:index, :show]
  resources :active_members, only: [:index, :show]
  resources :events, only: [:index, :show] do
    resources :comments, only: [:index, :show]
    resources :pictures, only: [:index, :show]
  end
  resources :locations, only: [:index, :show, :edit, :new]
  resources :venues, only: [:index, :show, :edit, :new]
  resources :contents, only: [:index, :show]

  devise_for :admins
  devise_for :users

  get '/' => redirect('/home')
  get '/about' => 'about#show'
  get '/faciliation' => 'application#faciliation'
  get '/imprint' => 'application#imprint'
  get '/guideline' => 'application#guideline'

  get '/home' => 'home#show'

  get '/users' => 'users#index'
  get '/users/:id' => 'users#show', as: 'user'

  get '/participate' => 'participate#show'
  post '/participate' => 'participate#create'

  get '/styleguide' => 'application#styleguide'
end
