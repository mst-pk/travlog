Rails.application.routes.draw do
  get 'likes/create'
  get 'likes/destroy'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  root to: 'pages#top'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :users do
    member do
      get :followings
      get :followers
    end
  end
  
  get 'signup', to: 'users#new'
  
  resources :events
  resources :relationships, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
  
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
