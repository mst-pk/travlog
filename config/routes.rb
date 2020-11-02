Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  root to: 'pages#top'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :users
  get 'signup', to: 'users#new'
  
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
