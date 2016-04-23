class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

    def real_account_name(account_name)
      if account_name == 'Default account'
        ''
      else
        account_name
      end
    end

    def try_encrypt
      begin
        return if @@encrypted
      rescue
        begin
          @bitcoin_client.encryptwallet session[:password]
          @@encrypted = true
        rescue
          @@encrypted = true
        end
      end
    end

    def check_user
      redirect_to '/login' unless session.has_key? :username
      @bitcoin_client = BitcoinRPC.new session[:username], session[:password]
      begin
        @information = @bitcoin_client.getinfo
        try_encrypt
        @current, @total = block_late
        @blockr = BlockrBtcApi.new
      rescue
        redirect_to '/login'
      end
    end

    def block_late
      current = @bitcoin_client.getblockcount
      uri = URI('https://blockchain.info/q/getblockcount')
      total = Net::HTTP.get(uri)
      return current.to_i, total.to_i
    end

    def list_select_accounts
      @select_account = @bitcoin_client.listaccounts.map { |name, balance|
                          name = 'Default account' if name == ''
                          ["#{name} - BTC #{balance}", name]
                        }
    end

end
