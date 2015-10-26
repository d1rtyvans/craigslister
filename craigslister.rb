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
      result = ""
      result += "min_price=#{low}&" if low
      result += "max_price=#{high}&" if high
      result
    end
end