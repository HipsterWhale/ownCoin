class WalletController < ApplicationController

  before_filter :check_user, :is_wallet_unlocked?

  def index
    basic_check_wallet
  end

  def try_unlock
    @error = !unlock_wallet(params[:password])
    redirect_to wallet_url
  end

  def send_bitcoins
    begin
      @bitcoin_client.sendfrom real_account_name(params[:send_from]), params[:send_to], params[:amount]
      @send_success = true
    rescue
      @send_failed = true
    end
    basic_check_wallet
    render :index
  end

  def do_lock
    lock_wallet
    session.delete :lock_date
    redirect_to wallet_url
  end

  private

    def basic_check_wallet
      if @wallet_unlocked
        @lock_date = lock_date
        list_select_accounts
      else
        # Enforce wallet locking
        lock_wallet
      end
    end

    def lock_wallet
      @bitcoin_client.walletlock
    end

    def unlock_wallet(password)
      begin
        @bitcoin_client.walletpassphrase(password, 600)
        true
      rescue
        false
      end
    end

    def lock_date
      DateTime.strptime(@information['unlocked_until'].to_s,'%s')
    end

    def is_wallet_unlocked?
      @wallet_unlocked = @information['unlocked_until'] > 0
    end

end
