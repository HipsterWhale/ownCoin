# OwnCoin

![logo](https://raw.githubusercontent.com/HipsterWhale/ownCoin/master/app/assets/images/owncoin_little.png)

The aim of this application is to provide a completely operational bitcoin full node and a wallet management in a single command for headless servers. The management of the wallet is done through a Web UI.
To achieve this in a secure way, I bundle a bitcoin daemon with a Ruby on Rails application that consume the JSON-RPC API of the bitcoin daemon.

**This is a work in progress, so do not use it right now !**

## How to run it

```
$ docker run -p 8003:8003 -p 80:80 \
    -v /volumes/bitcoin/data:/bitcoin_data \
    -e BC_USERNAME=myusername \
    -e BC_PASSWORD=mypassword \
    bahaika/owncoin
```

### About security

I think it's better to not serving the UI directly over the internet, since it can interact with the bitcoin daemon itself. It may be a good idea to create a VPN on the server hosting the application and then access the UI through it. To limit access of the UI to only the VPN, specify the IP when binding container port : `-p 10.8.0.1:80:80`
