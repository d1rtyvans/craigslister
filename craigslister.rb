class Craigslister
  attr_reader :area, :item

  def initialize args
    @area = args.fetch(:area, 'sfbay')
    @item = args.fetch(:item)
  end

  def url
    "https://#{area}.craigslist.org/"\
    "search/sss?sort=rel&"\
    "query=#{item.downcase.split(' ') * '+'}"
  end
end