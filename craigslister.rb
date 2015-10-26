require 'mechanize'

class InvalidRangeError < StandardError
end

class Craigslister
  attr_reader :area, :item, :high, :low
  attr_writer :url # only for tests

  def initialize args
    @area = args.fetch(:area, 'sfbay')
    @item = args.fetch(:item)
    @high = args.fetch(:high, nil)
    @low  = args.fetch(:low, nil)
    validate_price_range

    @mech = Mechanize.new
    configure_mech
  end

  def url
    "#{base_url}"\
    "search/sss?sort=rel&"\
    "#{price_query}"\
    "query=#{item.downcase.split(' ') * '+'}"\
  end

  def links
    @mech.get(url)
    @mech.page.search('.hdrlnk').map {|link| link['href']}
  end

  private
    def base_url
      "https://#{area}.craigslist.org/"
    end

    def price_query
      result = ''
      result += "min_price=#{low}&" if low
      result += "max_price=#{high}&" if high
      result
    end

    def configure_mech
      @mech.robots = false
      @mech.user_agent_alias = 'Mac Safari'
    end

    def validate_price_range
      if low && high
        raise InvalidRangeError if low > high
      end
    end
end

