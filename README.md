# Craigslister
[![Build Status](https://travis-ci.org/yago580/craigslister.svg)](https://travis-ci.org/yago580/craigslister)   [![Dependency Status](https://gemnasium.com/yago580/craigslister.svg)](https://gemnasium.com/yago580/craigslister) [![Code Climate](https://codeclimate.com/github/Yago580/craigslister/badges/gpa.svg)](https://codeclimate.com/github/Yago580/craigslister) [![Test Coverage](https://codeclimate.com/github/Yago580/craigslister/badges/coverage.svg)](https://codeclimate.com/github/Yago580/craigslister/coverage) [![Gem Version](https://badge.fury.io/rb/craigslister.svg)](https://badge.fury.io/rb/craigslister)

Scrape Craigslist for `Posts`.
#### RubyGems
```ruby
gem install craigslister
```
#### Bundler
```ruby
gem 'craigslister'
```

## Client
```ruby
require 'craigslister'

client = Craigslister.new(
  item: 'Couch',
  area: 'austin', # optional (defaults to 'sfbay')
  section: 'mca', # optional (defaults to 'sss')
  low:  500,      # optional
  high: 2000,     # optional
)
```

The `area` and `section` parameters must be valid Craigslist url query strings.

#### Areas
| Area              | Query         |
| ----------------- |:-------------:|
| SF bay area       | `'sfbay'`     |
| austin            | `'austin'`    |
| mendincino county | `'mendocino'` |

#### Sections
| Section       | Query        |
| ------------- |:------------:|
| motorcycles   | `'mca'`      |
| cars & trucks | `'cta'`      |
| appliances    | `'ppa'`      |



If you are unsure of what your local `area` query param may be it can be found in the browser when you navigate to craigslist, the same can be done with `section`. `'https://sfbay.craigslist.org/search/cta?query=chevy%20chevelle'`. Here `'sfbay'` would be the area (SF bay area), and `'cta'` would be the section (cars & trucks).

## Posts
`Post` objects are instantiated with the data scraped from a single page of a Craigslist post.
```ruby
# Post objects are instantiated with the data scraped from a single posting on Craigslist
couches = client.posts

# They have various attributes containing relevant post data
couch = couches[0]
couch.title
couch.image
couch.price
couch.location
couch.url
couch.description
```
