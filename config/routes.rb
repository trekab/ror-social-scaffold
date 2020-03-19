Rails.application.routes.draw do

  root 'posts#index'
  get 'invite-to-friendship/:id', to: 'users#invite_to_friendship', as: 'invite_to_friendship'
  get 'accept-friendship/:id', to: 'users#accept_friendship', as: 'accept_friendship'
  devise_for :users
  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
