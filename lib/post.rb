# Used for packaging Craigslist post data
class Post
  attr_reader :title, :image, :price, :location, :url

  def initialize(args)
    @title    = args[:title]
    @image    = args[:image]
    @price    = args[:price]
    @location = args[:location]
    @url      = args[:url]
  end
end
