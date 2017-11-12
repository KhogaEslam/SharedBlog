Rails.application.routes.draw do
  get 'favorites/favor/:id', to: 'favorites#favor', as: 'favor'
  get 'favorites/unfavor/:id', to: 'favorites#unfavor', as: 'unfavor'
  get 'favorites/my', to: 'favorites#my_favor', as: 'my_favor'


  get 'users/follow/:id', to: 'users#follow', as: 'follow'
  get 'users/unfollow/:id', to: 'users#unfollow', as: 'unfollow'
  get 'users/followings', to: 'users#followings', as: 'followings'

  get 'users/show/:id', to: 'users#show', as: 'show_user'

  mount Ckeditor::Engine => '/ckeditor'
  root to: "articles#index"
  resources :articles
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
