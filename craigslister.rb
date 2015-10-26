class Craigslister
  attr_reader :area, :item, :high, :low

  def initialize args
    @area = args.fetch(:area, 'sfbay')
    @item = args.fetch(:item)
    @high = args.fetch(:high, nil)
    @low  = args.fetch(:low, nil)
  end

  def url
    "https://#{area}.craigslist.org/"\
    "search/sss?sort=rel&"\
    "#{price_query}"\
    "query=#{item.downcase.split(' ') * '+'}"\
  end

  private
    def price_query
      if high && low
        "min_price=#{low}&max_price=#{high}&"
      elsif high
        "max_price=#{high}&"
      elsif low
        "min_price=#{low}&"
      end


      # https://sfbay.craigslist.org/search/sss?sort=rel&min_price=200&query=catnip


    end
end