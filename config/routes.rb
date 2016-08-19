Rails.application.routes.draw do
  root :to => redirect('/de')

  scope "(:locale)", locale: /de|en/ do
    resources :events
    devise_for :admins
    devise_for :users

    resources :comments
    resources :locations
    resources :pictures
    resources :venues

    get '/' => 'application#home'
    get '/home' => 'application#home'
    get '/users' => 'users#index'
    get '/faq' => 'application#faq'
    get '/contact' => 'application#contact'
    get '/imprint' => 'application#imprint'
    get '/privacy' => 'application#privacy'
  end
end
