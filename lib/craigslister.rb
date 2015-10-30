require 'nokogiri'
require 'open-uri'

class InvalidRangeError < StandardError
end

class Craigslister
  attr_reader :area, :item, :high, :low, :results

  def initialize args
    @results = []
    @area    = args.fetch(:area, 'sfbay')
    @item    = args[:item]
    @high    = args.fetch(:high, nil)
    @low     = args.fetch(:low, nil)
    validate_price_range
  end

  def scrape!
    links.each_with_index {|link, index| get_data_from(link, index)}
    results
  end

  def url
    "#{base_url}/"\
    "search/sss?sort=rel&"\
    "#{price_query}"\
    "query=#{item.downcase.split(' ') * '+'}"
  end

  def links
    page = Nokogiri::HTML(open(url))
    page.css('.hdrlnk').map {|link| format_link(link)}
  end


  private
    def base_url
      "https://#{area}.craigslist.org"
    end

    def get_data_from link, index
      page = Nokogiri::HTML(open(link))
      @results << Item.new(scrape_item_data(page, link)) rescue puts "No image for post ##{index+1}"
    end

    def scrape_item_data page, url
      {
        image: page.at('img')['src'],
        title: page.at('span.postingtitletext').text.gsub(/ ?- ?\$\d+ ?\(.+\)/, ''),
        price: page.at('span.postingtitletext span.price').text.gsub(/\$/,'').to_i,
        location: page.at('span.postingtitletext small').text.gsub(/ ?[\(\)]/,''),
        description: page.at('section#postingbody').text,
        url: url
      }
    end

    def format_link link
      link['href'] =~ /\w+\.craig/ ? "https:" + link['href'] : base_url + link['href']
    end

    def price_query
      result = ''
      result += "min_price=#{low}&" if low
      result += "max_price=#{high}&" if high
      result
    end

    def validate_price_range
      raise InvalidRangeError if low && high && low > high
    end
end

class Item
  attr_reader :title, :image, :price, :location, :url

  def initialize args
    @title    = args[:title]
    @image    = args[:image]
    @price    = args[:price]
    @location = args[:location]
    @url      = args[:url]
  end
end


# hondas = Craigslister.new(item: 'Honda CBR', low: 6000, high: 9000)
# hondas.scrape!

