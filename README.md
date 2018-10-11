# README

How to setup locally:


* brew install redis

* start up redis from your current app directory (homebrew provides 2 commands, choose one of them)

* start up sidekiq from your current app directory (simply type 'sidekiq')

## Redis
Startable via two options on mac:

redis-server /usr/local/etc/redis.conf

or

brew services start redis

To have launchd start redis now and restart at login:
  brew services start redis
Or, if you don't want/need a background service you can just run:
  redis-server /usr/local/etc/redis.conf