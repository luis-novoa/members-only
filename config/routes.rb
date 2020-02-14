Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  root "sessions#new"
  resources :sessions, only: [:new, :create, :destroy]
  resources :posts, only: [:new, :create, :index]
end
