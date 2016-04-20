class LoginController < ApplicationController

  def index
    render_view
  end

  def try_auth
    bc_client = BitcoinRPC.new params[:username], params[:password]
    begin
      bc_client.getbalance
      session[:username] = params[:username]
      session[:password] = params[:password]
      redirect_to '/home'
    rescue
      @error = true
      render_view
    end
  end

  def dispatcher
    if session.has_key? 'username'
      redirect_to '/home'
    else
      redirect_to '/login'
    end
  end

  private

    def render_view
      render :index, layout: nil
    end

end
