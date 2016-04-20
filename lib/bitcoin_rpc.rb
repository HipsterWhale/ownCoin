require 'net/http'
require 'uri'
require 'json'

class BitcoinRPC
  def initialize(username, password)
    bc_url = ENV['BC_URL'] || '127.0.0.1:8332'
    @uri = URI.parse("http://#{username}:#{password}@#{bc_url}")
  end

  def method_missing(name, *args)
    post_body = { method: name, params: args, id: 'jsonrpc' }.to_json
    resp = JSON.parse( http_post_request(post_body) )
    raise JSONRPCError, resp['error'] if resp['error']
    resp['result']
  end

  def http_post_request(post_body)
    http = Net::HTTP.new(@uri.host, @uri.port)
    request = Net::HTTP::Post.new(@uri.request_uri)
    request.basic_auth @uri.user, @uri.password
    request.content_type = 'application/json'
    request.body = post_body
    http.request(request).body
  end

  class JSONRPCError < RuntimeError; end
end
