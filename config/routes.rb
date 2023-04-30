Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"


  namespace :api do
    namespace :v1 do
      resources :blogs
      resources :users, param: :_username

      post '/auth/login', to: 'authentication#login'
    end
  end
end
