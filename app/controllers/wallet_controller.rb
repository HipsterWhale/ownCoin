class WalletController < ApplicationController

  before_filter :check_user, :is_wallet_unlocked?

  def index
    if @wallet_unlocked
      @lock_date = lock_date
      list_select_accounts
    else
      # Enforce wallet locking
      lock_wallet
    end
  end

  def try_unlock
    @error = !unlock_wallet(params[:password])
    redirect_to wallet_url
  end

  def send_bitcoins

  end

  def do_lock
    lock_wallet
    session.delete :lock_date
    redirect_to wallet_url
  end

  private

    def lock_wallet
      @bitcoin_client.walletlock
    end

    def unlock_wallet(password)
      begin
        @bitcoin_client.walletpassphrase(password, 600)
        session[:lock_date] = DateTime.now + 600.seconds
        true
      rescue
        false
      end
    end

    def lock_date
      DateTime.parse(session[:lock_date])
    end

    def is_wallet_unlocked?
      @wallet_unlocked = (session.has_key?(:lock_date) and not lock_date.past?)
    end

end
