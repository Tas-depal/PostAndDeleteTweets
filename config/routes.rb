Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'users#login'
  get "/home", to: 'users#index'
  
  get '/auth/twitter/callback', to: 'omniauth#twitter'
  get "/logout", to: 'twitter#logout'
  post "/delete", to: 'twitter#delete'
  resources :twitter, only: [:create, :new]

end
