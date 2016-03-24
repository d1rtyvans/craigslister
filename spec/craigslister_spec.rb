require 'spec_helper'

RSpec.describe Craigslister do
  context '#new' do
    it 'raises an error when given an invalid price range' do
      expect do
        Craigslister.new(item: 'srsly', low: 8000, high: 1)
      end.to raise_error { InvalidRangeError }
    end
  end

  context '#url' do
    it 'builds url with item argument' do
      hondas = Craigslister.new(item: 'Honda CBR')

      expect(hondas.url).to eq(
        'https://sfbay.craigslist.org/search/sss?sort=rel&query=honda+cbr')
    end

    it 'builds url with area argument' do
      harleys = Craigslister.new(area: 'austin', item: 'Harley Davidson')

      expect(harleys.url).to eq(
        'https://austin.craigslist.org/search/sss?sort=rel&query=harley+davidson')
    end

    it 'builds url with section argument' do
      harleys = Craigslister.new(
        area: 'austin', item: 'Harley Davidson', section: 'mca'
      )

      expect(harleys.url).to eq(
        'https://austin.craigslist.org/search/mca?sort=rel&query=harley+davidson')
    end

    it 'builds url with price range' do
      big_tv = Craigslister.new(item: 'BIG TV', low: 200, high: 2000)

      expect(big_tv.url).to eq(
        'https://sfbay.craigslist.org/search/sss?sort=rel&min_price=200&max_price=2000&query=big+tv')
    end

    it 'builds url with maximum price limit' do
      bigger_tv = Craigslister.new(item: 'BIGGER TV', high: 6000)

      expect(bigger_tv.url).to eq(
        'https://sfbay.craigslist.org/search/sss?sort=rel&max_price=6000&query=bigger+tv')
    end

    it 'builds url with minimum price limit' do
      cat_nip = Craigslister.new(item: 'Catnip', low: 200)

      expect(cat_nip.url).to eq(
        'https://sfbay.craigslist.org/search/sss?sort=rel&min_price=200&query=catnip')
    end
  end

  context '#posts' do
    it 'scrapes craigslist and returns post objects' do
      scraper = Craigslister.new(item: 'Honda CBR')
      hondas = scraper.posts

      expect(hondas.count).to eq(4)
    end
  end
end
