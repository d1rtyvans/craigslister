require 'spec_helper'

RSpec.describe LinkScraper do
  context '#links' do
    it 'scrapes post links from a craigslist page' do
      scraper = LinkScraper.new(
        absolute_path('test_page.html'), '')

      expect(scraper.links).to eq([
        './spec/support/fake_item_1.html',
        './spec/support/fake_item_1.html',
        './spec/support/fake_item_1.html',
        './spec/support/fake_item_1.html'])
    end

    it 'returns properly formatted links for out of town craigslist posts' do
      scraper = LinkScraper.new(
        absolute_path('out_of_town.html'), '')

      expect(scraper.links.first).to eq(
        'https://stockton.craigslist.org/mcy/5362368419.html')
    end
  end

  context '#posts' do
    it 'returns an array of "Posts"' do
      scraper = LinkScraper.new(
        absolute_path('test_page.html'), '')

      results = scraper.posts

      expect(results.count).to eq(4)
      expect(results[0].title).to eq('2015 Honda CBR 300R')
      expect(results[0].image).to eq('http://images.craigslist.org/00U0U_j8CHhaGW9Ze_600x450.jpg')
      expect(results[0].price).to eq(4399)
      expect(results[0].location).to eq('vallejo / benicia')
      expect(results[0].url).to eq('./spec/support/fake_item_1.html')
      expect(results[0].description).to eq('CHECK THE DESCRIPTION')
    end
  end
end
