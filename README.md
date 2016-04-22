# OwnCoin

![logo](https://raw.githubusercontent.com/HipsterWhale/ownCoin/master/app/assets/images/owncoin_little.png)

## What is it ?

OwnCoin is a bundle of a bitcoin server and a web application connecting to that server. The goal is to provide an easy and secure way to host your own bitcoin wallet, with multiple count support etc... To achieve such a goal we're using Docker to bundle all the things.

## How does this works inside ?

Inside the container the entrypoint will start the following components :
 - The OwnCoin application : A ruby on rails application launched by the Puma server
 - Nginx to serve the static files and proxy_pass calls to the Puma server
 - The bitcoin server to handle the wallet

## Can you show me what it looks like ?

I will soon upload some screenshots, probably in the mean time I'll be realising a stable version.

## Okay, I want to have it !

Great ! Glad to hear, here is how to deploy it, simply run this command on a server with docker installed :

```
$ docker run --name=owncoin \
    -p 8333:8333 -p 10080:80 \
    -v /mnt/volumes/owncoin:/data \
    -e BC_USERNAME=myusername \
    -e BC_PASSWORD=mypassword \
    -e SECRET_KEY_BASE=mysecret \
    bahaika/owncoin:latest
```

## I want to contribute !

There is two way for contrinuting to this software :

 - Make a pull request, I'll review it.
 - Make a donation to this bitcoin address : `1FhxGz1ZhX1VfBLedoanzwNaLuqvAAbRTd`

