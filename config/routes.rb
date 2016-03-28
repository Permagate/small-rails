Rails.application.routes.draw do
  devise_for :user, only: []
  
  namespace :v1, defaults: { format: :json } do
    resource :login, only: [:create], controller: :sessions
    resources :users, only: [:create]
    resources :stories, only: [:index, :show, :create, :update, :destroy] do
      collection do
        get 'me', to: :owned
      end
      member do
        post 'like'
      end
    end
    resources :comments, only: [:create, :update, :destroy] do
      collection do
        get 'me', to: :owned
      end
      member do
        post 'like'
      end
    end
  end
end
