# Rhinestone

Has it ever bothered you how long `bundle install` command takes to run?

It has bothered me, so I wrote Rhinestone: a simple proxy caches both the gems and the gem metadata.
It updates the cache *after* returning the response, so you get data that might be a little stale, but you get it very quickly.
You should deploy it somewhere in your local network (so that more people use the same cache).

## Installation

Just install it from RubyGems:

    gem install rhinestone

Below is the upstart script I used to make it run on Ubuntu:

```
# File: /etc/init/rhinestone.conf

# Rhinestone - a RubyGems.org proxy

description "rhinestone proxy server"

start on runlevel [23]
stop on shutdown

exec sudo rhinestone -p 80 -e prod -l /var/log/rhinestone.log -P /var/run/rhinestone.pid -C /var/rhinestone/cache

respawn
```

## Running

It's as simple as running:

    rhinestone

Rhinestone uses Goliath underneath, so there are some switches you can use:

    Server options:
        -e, --environment NAME           Set the execution environment (prod, dev or test) (default: development)
        -a, --address HOST               Bind to HOST address (default: 0.0.0.0)
        -p, --port PORT                  Use PORT (default: 9000)
        -S, --socket FILE                Bind to unix domain socket

    Daemon options:
        -u, --user USER                  Run as specified user
        -c, --config FILE                Config file (default: ./config/<server>.rb)
        -d, --daemonize                  Run daemonized in the background (default: false)
        -l, --log FILE                   Log to file (default: off)
        -s, --stdout                     Log to stdout (default: false)
        -P, --pid FILE                   Pid file (default: off)

    SSL options:
            --ssl                        Enables SSL (default: off)
            --ssl-key FILE               Path to private key
            --ssl-cert FILE              Path to certificate
            --ssl-verify                 Enables SSL certificate verification

    Common options:
        -v, --verbose                    Enable verbose logging (default: false)
        -h, --help                       Display help message

    Rhinestone-specific options:
        -C, --cache-path DIRECTORY       The directory where cache files will be stored


## Usage

Assuming you have Rhinestone running somewhere in your local network, add this to your Gemfile:

    source :rubygems
    source "http://rhinestone.local" # the address of rhinestone

This will speed up `bundle install` about 5-6x times, and even more if you remove the rubygems part completely (but I don't recommend that).
Note that the Rhinestone line is beneath rubygems one.
Otherwise bundler would download most of the gems directly from Rubygems and not from the proxy.

## Author

Adam Pohorecki

## License

MIT, see the MIT-LICENSE file.
