class HomeController < ApplicationController

  before_action :check_user

  def index
    @transactions = @bitcoin_client.listtransactions
  end

end
