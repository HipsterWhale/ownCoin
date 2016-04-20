class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

    def check_user
      redirect_to '/login' unless session.has_key? :username
      @bitcoin_client = BitcoinRPC.new session[:username], session[:password]
      begin
        @information = @bitcoin_client.getinfo
      rescue
        redirect_to '/login'
      end
    end

end
