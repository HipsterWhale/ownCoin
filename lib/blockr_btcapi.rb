class BlockrBtcApi

  def self.btc_to_eur(wanted_btc)
    current_rate = exchange_rate
    btc = current_rate['data']['rates']['BTC'].to_f
    eur = current_rate['data']['rates']['EUR'].to_f
    ((wanted_btc * eur) / btc).round(2)
  end

  private

    def self.exchange_rate
      if @@cached_rate and @@cached_rate[:expire_date].future?
        @@cached_rate[:current_rate]
      else
        current_rate = ask_api URI.parse('http://btc.blockr.io/api/v1/exchangerate/current')
        @@cached_rate = {
            expire_date: DateTime.now + 5.minutes,
            current_rate: current_rate
        }
        current_rate
      end
    end

    def self.ask_api(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Get.new(uri.request_uri)
      request.content_type = 'application/json'
      JSON.parse(http.request(request).body)
    end

end