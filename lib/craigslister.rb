require 'nokogiri'
require 'open-uri'

class InvalidRangeError < StandardError
end

class Craigslister
  attr_reader :area, :item, :high, :low

  def initialize(args)
    @area    = args.fetch(:area, 'sfbay')
    @item    = args[:item]
    @high    = args.fetch(:high, nil)
    @low     = args.fetch(:low, nil)
    validate_price_range
  end

  def scrape!
    links.flat_map { |link| item_from(link) }
  end

  def links
    page_from(url).css('.hdrlnk').map { |link| format_link(link) }
  end

  def url
    "#{base_url}/search/sss?sort=rel&"\
    "#{price_query}query="\
    "#{item.downcase.split(' ') * '+'}"
  end

  private

  def base_url
    "https://#{area}.craigslist.org"
  end

  def page_from(url)
    Nokogiri::HTML(open(url))
  end

  def format_link(link)
    if link['href'] =~ /\w+\.craig/
      'https:' + link['href']
    else
      base_url + link['href']
    end
  end

  def price_query
    result = ''
    result += "min_price=#{low}&" if low
    result += "max_price=#{high}&" if high
    result
  end

  def validate_price_range
    fail InvalidRangeError if low && high && low > high
  end

  def item_from(link)
    Item.new(get_item_data(page_from(link), link))
  end

  def get_item_data(page, link)
    {
      image: scrape_image(page),
      title: scrape_title(page),
      price: scrape_price(page),
      location: scrape_location(page),
      description: page.at('section#postingbody').text,
      url: link
    }
  end

  def scrape_image(page)
    page.at('img') ? page.at('img')['src'] : ''
  end

  def scrape_title(page)
    page.at('span.postingtitletext').text.gsub(/ ?- ?\$\d+ ?\(.+\)/, '')
  end

  def scrape_price(page)
    price = page.at('span.postingtitletext span.price')
    if price
      price.text.gsub(/\$/, '').to_i
    else
      0
    end
  end

  def scrape_location(page)
    location = page.at('span.postingtitletext small')
    if location
      location.text.gsub(/ ?[\(\)]/, '')
    else
      ''
    end
  end
end

class Item
  attr_reader :title, :image, :price, :location, :url

  def initialize(args)
    @title    = args[:title]
    @image    = args[:image]
    @price    = args[:price]
    @location = args[:location]
    @url      = args[:url]
  end
end
