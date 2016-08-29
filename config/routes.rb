Rails.application.routes.draw do
  resources :active_members
  root :to => redirect('/home')

  devise_for :admins
  devise_for :users

  resources :comments
  resources :events
  resources :locations
  resources :pictures
  resources :venues

  get '/' => 'application#home'
  get '/about' => 'application#about'
  get '/blog' => 'application#blog'
  get '/contact' => 'application#contact'
  get '/faq' => 'application#faq'
  get '/home' => 'application#home'
  get '/imprint' => 'application#imprint'
  get '/privacy' => 'application#privacy'
  get '/users' => 'users#index'
end
