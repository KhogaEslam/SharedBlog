Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  get '/about', to: 'static_pages#about', as: 'about'
  get '/help', to: 'static_pages#help', as: 'help'

  get '/signup', to: 'authors#new', as: 'signup'
  post '/signup', to: 'authors#create', as: 'register'

  get    '/login',   to: 'sessions#new', as: 'signin'
  post   '/login',   to: 'sessions#create', as: 'login'
  delete '/logout',  to: 'sessions#destroy', as: 'logout'

  get '/feed', to: 'authors#feed', as: 'feed'

  resources :articles

  # resources :authors
  resources :authors do
    member do
      get :following, :followers, :favorites
    end
  end

  resources :follows, only: [:create, :destroy]

  resources :favorites, only: [:create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get '/', to: 'static_pages#home', as: 'home'
  root 'static_pages#home'
end
