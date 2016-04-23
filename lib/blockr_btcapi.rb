require 'net/http'
require 'uri'
require 'json'

class BlockrBtcApi

  attr_accessor :cached_rate

  def btc_to_eur(wanted_btc)
    current_rate = exchange_rate
    btc = current_rate['data'][0]['rates']['BTC'].to_f
    eur = current_rate['data'][0]['rates']['EUR'].to_f
    ((wanted_btc * eur) / btc).round(2)
  end

  private

    def exchange_rate
      @cached_rate = ask_api(URI.parse('http://btc.blockr.io/api/v1/exchangerate/current')) unless @cached_rate
      @cached_rate
    end

    def ask_api(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Get.new(uri.request_uri)
      request.content_type = 'application/json'
      JSON.parse(http.request(request).body)
    end

end