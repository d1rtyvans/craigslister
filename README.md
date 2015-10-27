# Craigslister
```ruby
gem install 'craigslister'
```
Gemfile
```ruby
gem 'craigslister
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

couches.scrape # scrapes craigslist for matching items
couches.results # returns an array of item objects from scrape
```
Item objects
```ruby
item = couches.results[0]
item.title
#=> "Patterned cloth couch" 
item.image
#=> "http://images.craigslist.org/00S0S_jSLgjpOqOgw_600x450.jpg"
item.price
#=> 600
item.location
#=> "Sun City"
```
