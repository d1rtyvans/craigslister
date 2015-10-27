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

couches.scrape! # scrapes craigslist and returns array of matching items
couches.results # once items have been scraped, use #results to access matching items
```
Item objects
```ruby
item = couches.results[0]
item.title
#=> "Patterned cloth and solid wood couch" 
item.image
#=> "http://images.craigslist.org/00S0S_jSLgjpOqOgw_600x450.jpg"
item.price
#=> 600
item.location
#=> "Sun City"
item.url
#=> "https://austin.craigslist.org/fuo/5279693770.html"
```
