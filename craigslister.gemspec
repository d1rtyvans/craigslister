Gem::Specification.new do |s|
  s.name        = "craigslister"
  s.version     = "2.0.0"
  s.date        = "2015-11-11"
  s.summary     = "Scrape Craigslist for item objects"
  s.description = "all you need is an item title and you can scrape item objects from craigslist"
  s.authors     = ["Chris Scott"]
  s.email       = "christo247@gmail.com"
  s.files       = ["lib/craigslister.rb"]
  s.homepage    = "https://github.com/Yago580/craigslister"
  s.license     = 'MIT'
  s.add_runtime_dependency 'nokogiri', '~> 1.6', '>= 1.6.6.2'
end
