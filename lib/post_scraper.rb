# Creates Post objects out of an HTML page
class PostScraper
  def initialize(page, link)
    @page = page
    @link = link
  end

  def new_post
    Post.new(
      image: image,
      title: title,
      price: price,
      location: location,
      description: page.at('section#postingbody').text,
      url: link
    )
  end

  private

  attr_reader :page, :link

  def image
    image = page.at('img')
    image ? image['src'] : ''
  end

  def title
    page.at('span.postingtitletext').text.gsub(/ ?- ?\$\d+ ?\(.+\)/, '')
  end

  def price
    price = page.at('span.postingtitletext span.price')
    if price
      price.text.gsub(/\$/, '').to_i
    else
      0
    end
  end

  def location
    location = page.at('span.postingtitletext small')
    if location
      location.text.gsub(/ ?[\(\)]/, '')
    else
      ''
    end
  end
end
