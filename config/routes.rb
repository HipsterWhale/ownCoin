Rails.application.routes.draw do

  root to: 'login#dispatcher'

  # Login controller
  get '/login', to: 'login#index', as: 'login'
  post '/login', to: 'login#try_auth', as: 'login_try_auth'

end
