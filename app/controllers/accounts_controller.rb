class AccountsController < ApplicationController

  before_filter :check_user
  before_action :list_accounts

  def index
  end

  def create
    account_name = params[:account_name]
    if @accounts.has_key? account_name or account_name.blank?
      @account_name_exists = true
    else
      @bitcoin_client.getaccountaddress account_name
      list_accounts
      @account_created = true
    end
    render :index
  end

  private

    def list_accounts
      @accounts = @bitcoin_client.listaccounts
    end

end
