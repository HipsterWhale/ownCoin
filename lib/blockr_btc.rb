require 'net/http'
require 'uri'
require 'json'

class BlockrBtc

  @@cached_rate = nil

  API_URL = URI.parse('http://btc.blockr.io/api/v1/exchangerate/current')

  def btc_to_eur(wanted_btc)
    current_rate = exchange_rate
    btc = current_rate['data'][0]['rates']['BTC'].to_f
    eur = current_rate['data'][0]['rates']['EUR'].to_f
    ((wanted_btc * eur) / btc).round(2)
  end

  def btc_to_usd(wanted_btc)
    current_rate = exchange_rate
    btc = current_rate['data'][0]['rates']['BTC'].to_f
    usd = current_rate['data'][0]['rates']['USD'].to_f
    ((wanted_btc * usd) / btc).round(2)
  end

  private

    def exchange_rate
      if @@cached_rate and @@cached_rate[:date].future?
        puts 'from cache'
        @@cached_rate[:rate]
      else
        puts 'from api'
        current_rate = ask_api(API_URL)
        @@cached_rate = {
            rate: current_rate,
            date: DateTime.now + 10.minutes
        }
        current_rate
      end
    end

    def ask_api(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Get.new(uri.request_uri)
      request.content_type = 'application/json'
      JSON.parse(http.request(request).body)
    end

end