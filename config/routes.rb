Rails.application.routes.draw do

  root to: 'login#dispatcher'

  # Login controller
  get '/login', to: 'login#index', as: 'login'
  post '/login', to: 'login#try_auth', as: 'login_try_auth'
  delete '/login', to: 'login#destroy', as: 'logout'

  # Home controller
  get '/home', to: 'home#index', as: 'home'
  get '/home/addresses', to: 'home#addresses', as: 'home_addresses'

end
