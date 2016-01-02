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
      description: description,
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
    price ? price.text.gsub(/\$/, '').to_i : 0
  end

  def location
    location = page.at('span.postingtitletext small')
    location ? location.text.gsub(/ ?[\(\)]/, '') : ''
  end

  def description
    page.at('section#postingbody').text
  end
end
