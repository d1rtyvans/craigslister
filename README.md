# Craigslister
Ever found yourself wishing Craigslist had an api? Craigslister is here to save the day. Use Craigslister and scrape Craigslist for its data in neatly packaged Item objects. All you need is the name of an item!
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

couches = Craigslister.new(
  item: 'Couch',
  area: 'austin', #optional, defaults to 'sfbay' (must be valid craigslist area prefix)
  low: 500, #optional (minimum price range)
  high: 2000, #optional (maximum price range)
)

results = couches.scrape # scrapes craigslist and returns array of matching items
```
Item objects
```ruby
couch = results[0]
couch.title
#=> "Patterned cloth and solid wood couch" 
couch.image
#=> "http://images.craigslist.org/00S0S_jSLgjpOqOgw_600x450.jpg"
couch.price
#=> 600
couch.location
#=> "Sun City"
couch.url
#=> "https://austin.craigslist.org/fuo/5279693770.html"
couch.description
#=> "Totally awesome couch! You should buy it! Blah, blah, blah."
```
