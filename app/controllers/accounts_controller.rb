class AccountsController < ApplicationController

  before_filter :check_user
  before_action :list_accounts

  def index
    list_select_accounts
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
    list_select_accounts
    render :index
  end

  def addresses
    list_addresses
  end

  def new_address
    @new_address = @bitcoin_client.getnewaddress(params[:account_name])
    list_addresses
    render :addresses
  end

  def transactions
    @transactions = @bitcoin_client.listtransactions(real_account_name(params[:account_name]))
  end

  def move
    @bitcoin_client.move(real_account_name(params[:from_account]),
                         real_account_name(params[:to_account]),
                         params[:amount])
    redirect_to accounts_path
  end

  private

    def list_accounts
      @accounts = @bitcoin_client.listaccounts
    end

    def list_addresses
      @addresses = @bitcoin_client.listreceivedbyaddress(0, true).select { |address|
        address['account'] == real_account_name(params[:account_name])
      }
    end

end
