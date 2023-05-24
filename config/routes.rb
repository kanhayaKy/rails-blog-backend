Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"


  namespace :api do
    namespace :v1 do
      resources :users, param: :_username do
        resources :posts do
          member do
            post :like
            post :dislike
          end
          resources :comments, only: [:create, :update, :destroy]
        end

        post 'follow', to: 'follows#create', as: 'follow'
        delete 'unfollow', to: 'follows#destroy', as: 'unfollow'
      end

      resources :posts, only: [:index, :create]

      post '/auth/login', to: 'authentication#login'
      get '/auth/user', to: 'authentication#user_details'
      delete '/auth/logout', to: 'authentication#logout'
    end
  end
end
