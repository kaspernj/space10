require 'api_constraints'

Rails.application.routes.draw do
  
  root 'static_pages#home'

  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  get 'auth/:provider/callback', to: 'sessions#create_with_omniauth'
  get 'auth/failure', to: 'sessions#omniauth_failure'

  resources :users
  resources :sessions
  resources :events, only: [:index, :show] do
    resources :registrations
  end

  namespace :admin do
  	get "/", to: "static_pages#dashboard", as: "root"
  	resources :events do
      resources :registrations
      post 'confirm_registration', to: 'registrations#confirm_registration', as: 'confirm_registration'
    end
  end

  namespace :api do
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

      post 'authenticate', to: 'sessions#new'
      get 'auth/:provider/callback', to: 'sessions#create_with_omniauth'
      get 'auth/failure', to: 'sessions#omniauth_failure'

      get 'events', to: 'events#index'
      get 'events/:id', to: 'events#show'
    end
  end

end
