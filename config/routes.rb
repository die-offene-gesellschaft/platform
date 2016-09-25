Rails.application.routes.draw do
  scope '/auth' do
    devise_for :admins
    devise_for :users
  end

  resources :blogposts, only: [:index, :show]
  resources :active_members, only: [:index, :show]
  resources :events, only: [:index, :show] do
    resources :comments, only: [:index, :show]
    resources :pictures, only: [:index, :show]
  end
  resources :locations, only: [:index, :show, :edit, :new]
  resources :venues, only: [:index, :show, :edit, :new]
  resources :contents, only: [:index, :show]

  get '/' => redirect('/home')

  get '/about' => 'about#show'
  get '/faciliation' => 'application#faciliation'
  get '/imprint' => 'application#imprint'
  get '/guideline' => 'application#guideline'

  %w(about faciliation imprint guideline).each do |content_resource|
    get "/#{content_resource}/edit" => 'application#content_edit'
    patch "/#{content_resource}" => 'application#content_update'
  end

  get '/home' => 'home#show'

  get '/users' => 'users#index'
  get '/users/:id' => 'users#show', as: 'user'

  get '/participate' => 'participate#show'
  post '/participate' => 'participate#create'

  get '/styleguide' => 'application#styleguide'

end
