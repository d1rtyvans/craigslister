# Scrapes craigslist posts and packages data in Post objects
class PostScraper
  def initialize(page, link)
    @page = page
    @link = link
  end

  def new_post
    Post.new(post_params)
  end

  private

  attr_reader :page, :link

  def posting_title
    page.at('span.postingtitletext')
  end

  def post_params
    {
      image: image,
      title: title,
      price: price,
      location: location,
      description: description,
      url: link,
      bedrooms: bedrooms,
      bathrooms: bathrooms,
      other: other,
    }
  end

  def support_bubbles
    page.css('span.shared-line-bubble')
  end

  def lower_support_bubbles
    page.css('p.attrgroup')
  end

  def bed_bath
    support_bubbles&.first&.children
  end

  def square_footage
    support_bubbles&.last&.at('b')&.text
  end

  def bedrooms
    return unless bed_bath.present?

    bed_bath.first.text
  end

  def bathrooms
    return unless bed_bath.present?

    bed_bath.last.text
  end

  def other
    lower_support_bubbles&.last&.children&.
      map { |el| el&.text&.strip }&.
      reject { |el| el&.empty? }
  end

  def image
    image = page.at('img')
    image ? image['src'] : ''
  end

  def title
    posting_title.text.gsub(/ ?- ?\$\d+ ?\(.+\)/, '')
  end

  def price
    price = posting_title.at('span.price')
    price ? price.text.gsub(/\$/, '').to_i : 0
  end

  def location
    location = posting_title.at('small')
    location ? location.text.gsub(/ ?[\(\)]/, '') : ''
  end

  def description
    page.at('section#postingbody').text
  end
end
