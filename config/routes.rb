Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'
  get 'about', to: 'pages#about'
  resources :pictures
  resources :users, except: [:destroy]
  post 'users/new', to: 'users#create'
end
