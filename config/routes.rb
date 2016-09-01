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
  get '/about' => 'application#about'
  get '/blog' => 'application#blog'
  get '/contact' => 'application#contact'
  get '/faq' => 'application#faq'
  get '/home' => 'home#show'
  get '/imprint' => 'application#imprint'
  get '/privacy' => 'application#privacy'
  get '/users' => 'users#index'
end
