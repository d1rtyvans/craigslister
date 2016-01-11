require 'spec_helper'

RSpec.describe PostScraper do
  context '#new_post' do
    it 'returns a post object' do
      link = absolute_path('fake_item_1.html')
      page = Nokogiri::HTML(open(link))

      post_scraper = PostScraper.new(page, link)
      post = post_scraper.new_post

      expect(post.title).to eq('2015 Honda CBR 300R')
      expect(post.image).to eq('http://images.craigslist.org/00U0U_j8CHhaGW9Ze_600x450.jpg')
      expect(post.price).to eq(4399)
      expect(post.location).to eq('vallejo / benicia')
      expect(post.description).to eq('CHECK THE DESCRIPTION')
    end
  end
end
