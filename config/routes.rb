Rails.application.routes.draw do
  devise_for :user, only: []
  
  namespace :v1, defaults: { format: :json } do
    resource :login, controller: :sessions
    resources :users, only: [:create]
    resources :stories do
      collection do
        get 'me', to: :owned
      end
    end
    resources :comments do
      collection do
        get 'me', to: :owned
      end
    end
  end
end
