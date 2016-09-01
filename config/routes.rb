Rails.application.routes.draw do
  resources :active_members

  devise_for :admins
  devise_for :users

  resources :comments
  resources :events
  resources :locations
  resources :pictures
  resources :venues

  get '/' => redirect('/home')
  get '/about' => 'about#show'
  get '/blog' => 'blog#show'
  get '/contact' => 'application#contact'
  get '/faq' => 'application#faq'
  get '/home' => 'home#show'
  get '/imprint' => 'application#imprint'
  get '/privacy' => 'application#privacy'

  get '/users' => 'users#index'
  get '/users/:id' => 'users#show', as: 'user'
end
