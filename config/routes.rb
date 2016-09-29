Rails.application.routes.draw do
  scope '/auth' do
    devise_for :admins
    devise_for :users, controllers: { confirmations: 'confirmations' }
  end

  resources :blogposts, only: [:index, :show]
  resources :active_members, only: [:index, :show]
  resources :events do
    resources :comments, only: [:index, :show]
    resources :pictures, only: [:index, :show]
  end
  resources :locations, only: [:index, :show, :edit, :new]
  resources :venues, only: [:index, :show, :create, :update, :edit, :new]
  resources :contents, only: [:index, :show]
  resources :admins
  resources :users, except: [:new, :create]

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

  get '/events_admin_index',
      to: 'events#admin_index',
      as: 'admin_index'

  get '/styleguide' => 'application#styleguide'
end
