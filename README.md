# OwnCoin

[logo](https://raw.githubusercontent.com/HipsterWhale/ownCoin/master/app/assets/images/owncoin.png)

The aim of this application is to provide a completely operational bitcoin full node and a wallet management in a single command for headless servers. To do this, I bundle a bitcoin daemon with a Ruby on Rails application that consume the JSON-RPC API of the bitcoin daemon.

**This is a work in progress, so do not use it right now !**

If you want to contribute on this project you can do it by :

 - Contributing to the project with pull requests
 - Make a donation in bitcoin to this address : *1FhxGz1ZhX1VfBLedoanzwNaLuqvAAbRTd*

## How to run it

```
$ docker run -p 8003:8003 -p 80:80 \
    -v /volumes/bitcoin/data:/bitcoin_data \
    -e BC_USERNAME=myusername \
    -e BC_PASSWORD=mypassword \
    bahaika/owncoin
```
