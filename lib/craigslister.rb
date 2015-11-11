require 'nokogiri'
require 'open-uri'


class InvalidRangeError < StandardError
end


class Craigslister
  attr_reader :area, :item, :high, :low, :results

  def initialize args
    @area    = args.fetch(:area, 'sfbay')
    @item    = args[:item]
    @high    = args.fetch(:high, nil)
    @low     = args.fetch(:low, nil)
    validate_price_range
  end

  def scrape!
    links.map {|link| item_from(link)}.compact
  end

  def links
    page_from(url).css('.hdrlnk').map {|link| format_link(link)}
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
      Item.new(get_item_data(page_from(link), link))
    end

    def get_item_data page, link
      {
        image: scrape_image(page),
        title: page.at('span.postingtitletext').text.gsub(/ ?- ?\$\d+ ?\(.+\)/, ''),
        price: scrape_price(page),
        location: scrape_location(page),
        description: page.at('section#postingbody').text,
        url: link
      }
    end

    def scrape_image page
      page.at('img') ? page.at('img')['src'] : ""
    end

    def scrape_price page
      if price = page.at('span.postingtitletext span.price')
        price.text.gsub(/\$/,'').to_i
      else
        0
      end
    end

    def scrape_location page
      if location = page.at('span.postingtitletext small')
        location.text.gsub(/ ?[\(\)]/,'')
      else
        ""
      end
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

  # THIS BETTER BE TABBED CORRECTLY BRO
