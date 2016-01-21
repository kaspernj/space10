require 'api_constraints'

Rails.application.routes.draw do
  
  root 'static_pages#home'

  get 'about', to: 'static_pages#about', as: 'about'

  # TEMPORARY
  get 'invitation' => redirect('https://rebelunited-yuji.squarespace.com/invitation')

  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  get 'auth/:provider/callback', to: 'sessions#create_with_omniauth'
  get 'auth/failure', to: 'sessions#omniauth_failure'

  resources :users
  resources :sessions
  resources :events, only: [:index, :show], path: "program" do
    resources :registrations
  end
  resources :posts, only: [:index, :show], path: "journal"
  resources :profiles, only: [:index, :show], path: "community"
  resources :labs, only: [:index, :show]
  resources :tags, only: [:index, :show]
  resources :press_mentions, only: [:index]
  resources :messages
  resources :password_resets

  post 'video_preview', to: 'video_preview#create', as: 'video_preview'

  get 'search', to: 'search#search', as: 'search'
  post 'search', to: 'search#search_results', as: 'search_results'

  namespace :admin do
  	get "/", to: "static_pages#dashboard", as: "root"
  	resources :events do
      resources :registrations
      post 'confirm_registration', to: 'registrations#confirm_registration', as: 'confirm_registration'
    end
    resources :posts
    resources :profiles
    resources :labs
    resources :tags
    resources :press_mentions
    
    get 'edit_settings', to: 'settings#edit', as: 'edit_settings'
    put 'update_settings', to: 'settings#update', as: 'update_settings'
  end

  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      post 'users', to: 'users#create'
      get 'user', to: 'users#show'
      put 'user', to: 'users#update'

      namespace :user do
        get 'registrations', to: 'registrations#index'
        post 'registrations', to: 'registrations#create'
        get 'registrations/:id', to: 'registrations#show'
        delete 'registrations/:id', to: 'registrations#destroy'
      end

      post 'authenticate', to: 'sessions#create'
      post 'auth/:provider/callback', to: 'sessions#create_with_omniauth'
      get 'auth/failure', to: 'sessions#omniauth_failure'

      get 'events', to: 'events#index'
      get 'future_events', to: 'events#future'
      get 'historic_events', to: 'events#historic'
      get 'events/:id', to: 'events#show'

      get 'posts', to: 'posts#index'
      get 'posts/:id', to: 'posts#show'

      get 'profiles', to: 'profiles#index'
      get 'profiles/filter_options', to: 'profiles#filter_options'
      get 'profiles/:id', to: 'profiles#show'

      get 'profile_tags', to: 'tags#profile_tags'
      get 'post_tags', to: 'tags#post_tags'

      resources :labs, only: [:index, :show] do
        get 'posts', to: 'posts#index'

        get 'future_events', to: 'events#future'
        get 'historic_events', to: 'events#historic'
      end
    end
  end

end
