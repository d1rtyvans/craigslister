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
    @results = links.map {|link| item_from(link)}.compact
  end

  def url
    "#{base_url}/search/sss?sort=rel&"\
    "#{price_query}query="\
    "#{item.downcase.split(' ') * '+'}"
  end

  def links
    page_from(url).css('.hdrlnk').map {|link| format_link(link)}
  end


  private
    def base_url
      "https://#{area}.craigslist.org"
    end

    def page_from url
      Nokogiri::HTML(open(url))
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
    

    def item_from link
      item_data = scrape_item_data(page_from(link), link)
      Item.new(item_data) if item_data
    end

    def scrape_item_data page, link
      {
        image: page.at('img')['src'],
        title: page.at('span.postingtitletext').text.gsub(/ ?- ?\$\d+ ?\(.+\)/, ''),
        price: page.at('span.postingtitletext span.price').text.gsub(/\$/,'').to_i,
        location: page.at('span.postingtitletext small').text.gsub(/ ?[\(\)]/,''),
        description: page.at('section#postingbody').text,
        url: link
      }
    rescue
      puts "Found post with no image."
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
