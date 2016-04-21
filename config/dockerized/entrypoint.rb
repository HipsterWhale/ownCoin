#!/usr/bin/ruby

BITCOIN_CONF_FILE='/etc/bitcoin.conf'

def generate_bitcoind_config
  config_file = []
  config_file << 'printtoconsole=1'
  config_file << "rpcuser=#{ENV['BC_USERNAME']}"
  config_file << "rpcpassword=#{ENV['BC_PASSWORD']}"
  config_file << 'rpcport=8332'
  config_file << 'rpcconnect=127.0.0.1'
  config_file << 'rpcssl=0'
  config_file << 'datadir=/data/bicoind'
  File.open(BITCOIN_CONF_FILE, 'w') do |file|
    file.write config_file.join("\n")
  end
end

if ARGV.count == 0
  # No args passed, doing normal lunch...

  # Starting nginx
  fork do
    exec 'nginx'
  end

  # Starting puma
  fork do
    exec 'puma -b unix:///var/run/puma.sock -e RPC_USERNAME='
  end

  # Starting bitcoin daemon
  fork do
    # Generating bitcoin daemon configuration
    generate_bitcoind_config unless File.exists? BITCOIN_CONF_FILE
    exec "bitcoind 	-conf=#{BITCOIN_CONF_FILE}"
  end

  # Sleep main process
  sleep
else
  # Args passed, starting custom command
  command = ARGV.join(' ')
  exec command
end
