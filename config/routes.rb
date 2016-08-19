Rails.application.routes.draw do
  root :to => redirect('/de')

  devise_for :admins
  devise_for :users

  scope "(:locale)", locale: /de|en/ do
    resources :events

    resources :comments
    resources :locations
    resources :pictures
    resources :venues

    get '/' => 'application#home'
    get '/home' => 'application#home'
    get '/users' => 'users#index'
    get '/faq' => 'application#faq'
    get '/contact' => 'application#contact'
    get '/about' => 'application#about'
    get '/blog' => 'application#blog'
    get '/imprint' => 'application#imprint'
    get '/privacy' => 'application#privacy'
  end
end
