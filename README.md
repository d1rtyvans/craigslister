# Craigslister
[![Build Status](https://travis-ci.org/yago580/craigslister.svg)](https://travis-ci.org/yago580/craigslister)   [![Dependency Status](https://gemnasium.com/yago580/craigslister.svg)](https://gemnasium.com/yago580/craigslister) [![Code Climate](https://codeclimate.com/github/Yago580/craigslister/badges/gpa.svg)](https://codeclimate.com/github/Yago580/craigslister) [![Test Coverage](https://codeclimate.com/github/Yago580/craigslister/badges/coverage.svg)](https://codeclimate.com/github/Yago580/craigslister/coverage)

Scrape Craigslist for `Posts`.
#### RubyGems
```ruby
gem install craigslister
```
#### Bundler
```ruby
gem 'craigslister'
```

## Use
```ruby
require 'craigslister'

client = Craigslister.new(
  item: 'Couch',
  area: 'austin', #optional, defaults to 'sfbay'
  low: 500, #optional
  high: 2000, #optional
)

couches = client.posts
```
Item objects
```ruby
couch = couches[0]
couch.title
couch.image
couch.price
couch.location
couch.url
couch.description
```
