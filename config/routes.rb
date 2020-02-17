Rails.application.routes.draw do
  get 'users/new'
  get 'users/create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'
  root "sessions#new"
  resources :sessions, only: [:new, :create, :destroy]
  resources :posts, only: [:new, :create, :index]
  resources :users, only: [:new, :create, :index]
end
