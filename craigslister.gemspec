Gem::Specification.new do |s|
  s.name        = "craigslister"
  s.version     = "0.1.0"
  s.date        = "2015-10-27"
  s.summary     = "Scrape Craigslist!!!!! heh heh heh"
  s.description = "all you need is an item title and you can scrape item objects from craigslist"
  s.authors     = ["Chris Scott"]
  s.email       = "christo247@gmail.com"
  s.files       = ["lib/craigslister.rb"]
  s.homepage    =
    'http://rubygems.org/gems/craigslister'
  s.license       = 'MIT'
  s.add_runtime_dependency 'nokogiri', '~> 1.6', '>= 1.6.6.2'
end