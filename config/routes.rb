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
  get '/accounts/:account_name/addresses', to: 'accounts#addresses', as: 'accounts_addresses'
  post '/accounts/:account_name/addresses', to: 'accounts#new_address'
  get '/accounts/:account_name/transactions', to: 'accounts#transactions', as: 'accounts_transactions'
  post '/accounts/move', to: 'accounts#move', as: 'accounts_move'

  # Wallet controller
  get '/wallet', to: 'wallet#index', as: 'wallet'
  get '/wallet/download', to: 'wallet#download', as: 'wallet_download'
  post '/wallet', to: 'wallet#try_unlock'
  delete '/wallet', to: 'wallet#do_lock'
  post '/wallet/send', to: 'wallet#send_bitcoins', as: 'wallet_send'
  post '/wallet/change', to: 'wallet#change_password', as: 'wallet_change'

end
