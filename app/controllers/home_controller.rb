class HomeController < ApplicationController

  before_action :check_user

  def index
    @transactions = @bitcoin_client.listtransactions
  end

  def addresses
    @addresses = @bitcoin_client.listreceivedbyaddress(0, true)
  end

end
