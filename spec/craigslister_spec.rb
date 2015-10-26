require 'spec_helper'
require_relative '../craigslister'


# stubs #url and #links so that Craigslister can be tested
  # seperate from the live website... couldn't come up with
  # a better way to do this
class Tester < Craigslister
  def url
    "#{Dir.pwd}/test_page.html"
  end

  def links
    page = Nokogiri::HTML(open(url))
    page.css('.hdrlnk').map {|link| link['href']}
  end
end



RSpec.describe Craigslister do
  it 'creates an instance of Mechanize' do
    allow(Mechanize).to receive(:new).and_return(Mechanize.new)

    kewl_thing = Craigslister.new(item: 'kewl thing')

    expect(Mechanize).to have_received(:new)
  end

  context 'when given invalid price range' do
    it 'raises an error' do
      expect{
        Craigslister.new(item: 'srsly', low: 8000, high: 1)
      }.to raise_error{InvalidRangeError}
    end
  end
end




RSpec.describe Craigslister, '#url' do
  it 'builds craigslist url from arguments' do
    hondas = Craigslister.new(item: 'Honda CBR')

    expect(hondas.url).to eq(
      'https://sfbay.craigslist.org/search/sss?sort=rel&query=honda+cbr')
  end

  context 'when given area argument' do
    it 'builds url with that area' do
      harleys = Craigslister.new(area: 'austin', item: 'Harley Davidson')

      expect(harleys.url).to eq(
        'https://austin.craigslist.org/search/sss?sort=rel&query=harley+davidson')
    end
  end

  context 'when given a price range' do
    it 'builds url with that price range' do
      big_tv = Craigslister.new(item: 'BIG TV', low: 200, high: 2000)

      expect(big_tv.url).to eq(
        'https://sfbay.craigslist.org/search/sss?sort=rel&min_price=200&max_price=2000&query=big+tv')
    end
  end

  context 'when given a maximum price' do
    it 'builds url with maximum price limit' do
      bigger_tv = Craigslister.new(item: 'BIGGER TV', high: 6000)

      expect(bigger_tv.url).to eq(
        'https://sfbay.craigslist.org/search/sss?sort=rel&max_price=6000&query=bigger+tv')
    end
  end

  context 'when given a minimum price' do
    it 'builds url with a minimum price limit' do
      cat_nip = Craigslister.new(item: 'Catnip', low: 200)

      expect(cat_nip.url).to eq(
        "https://sfbay.craigslist.org/search/sss?sort=rel&min_price=200&query=catnip")
    end
  end
end





RSpec.describe Craigslister, '#links' do
  it 'returns an array of all item urls on a query page' do
    hondas = Tester.new(item: 'Honda CBR', low: 2000, high: 6000)

    expect(hondas.links.count).to eq(4)
    expect(hondas.links[0]).to eq("/eby/mcd/5274935295.html")
  end
end



RSpec.describe Craigslister, '#results' do
  it 'returns an array of "Items"' do
    hondas = Craigslister.new(item: 'Honda CBR', low: 2000, high: 6000)
    hondas.scrape

    # expect(hondas.results.count).to eq(4)
    expect(hondas.results.count).to eq(92)
    expect(hondas.results[0].title).to eq("2015 Honda CBR® 300R")
    expect(hondas.results[0].image).to eq("http://images.craigslist.org/00U0U_j8CHhaGW9Ze_600x450.jpg")
    expect(hondas.results[0].price).to eq(4399)
    expect(hondas.results[0].location).to eq("vallejo / benicia")
  end
end