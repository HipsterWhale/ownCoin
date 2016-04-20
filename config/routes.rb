Rails.application.routes.draw do

  root to: 'login#dispatcher'

  # Login controller
  get '/login', to: 'login#index', as: 'login'
  post '/login', to: 'login#try_auth'
  delete '/login', to: 'login#destroy', as: 'logout'

  # Home controller
  get '/home', to: 'home#index', as: 'home'

  # Accounts controller
  get '/accounts', to: 'accounts#index', as: 'accounts'
  post '/accounts', to: 'accounts#create'
  get '/accounts/:account_name/address', to: 'accounts#addresses', as: 'accounts_addresses'
  get '/accounts/:account_name/transactions', to: 'accounts#transactions', as: 'accounts_transactions'

  # Wallet controller
  get '/wallet', to: 'wallet#index', as: 'wallet'
  post '/wallet', to: 'wallet#try_unlock'
  delete '/wallet', to: 'wallet#do_lock'
  post '/wallet/send', to: 'wallet#send_bitcoins', as: 'wallet_send'

end
