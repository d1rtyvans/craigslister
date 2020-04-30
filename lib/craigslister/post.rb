# Used for packaging Craigslist post data
class Post
  attr_reader :bathrooms,
              :bedrooms,
              :description,
              :image,
              :location,
              :other,
              :price,
              :title,
              :url

  def initialize(args)
    @bathrooms   = args[:bathrooms]
    @bedrooms    = args[:bedrooms]
    @description = args[:description]
    @image       = args[:image]
    @location    = args[:location]
    @other       = args[:other]
    @price       = args[:price]
    @title       = args[:title]
    @url         = args[:url]
  end

  def attributes
    {
      bathrooms: bathrooms,
      bedrooms: bedrooms,
      description: description,
      image: image,
      location: location,
      other: other,
      price: price,
      title: title,
      url: url
    }
  end
end
