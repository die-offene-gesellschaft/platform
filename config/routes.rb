Rails.application.routes.draw do
  scope '/auth' do
    devise_for :admins, controllers: { sessions: 'sessions' }
    devise_for :users, controllers: { sessions: 'sessions', confirmations: 'confirmations' }
  end

  resources :organizers
  resources :blogposts
  resources :active_members, only: [:index, :show]
  resources :events do
    resources :comments, only: [:index, :show]
    resources :pictures, only: [:index, :show]
    resources :statements, only: [:index, :show, :destroy, :create, :update]
    resources :organizers, only: [:index, :show, :destroy]
  end
  resources :statements, only: [:index, :show]
  resources :locations, only: [:index, :show, :edit, :new]
  resources :venues
  resources :contents, only: [:index, :show, :edit, :update]
  resources :admins
  resources :press_reviews
  resources :ideas, except: [:show, :new, :create]
  resources :users, except: [:new, :create] do
    delete '/avatar',
           to: 'users#delete_avatar',
           as: 'delete_avatar'
  end

  get '/' => redirect('/home')
  get '/home' => 'home#show'
  get '/about' => 'about#show'
  get '/faciliation' => 'application#faciliation'
  get '/imprint' => 'application#imprint'
  get '/guideline' => 'application#guideline'

  %w(about faciliation imprint guideline participate).each do |content_resource|
    get "/#{content_resource}/edit" => 'application#content_edit'
    patch "/#{content_resource}" => 'application#content_update'
  end

  get '/participate' => 'participate#show'
  post '/participate' => 'participate#create'

  get '/styleguide' => 'application#styleguide'
end
