# Houses all logic for interacting with craigslist.org
class ItemSearcher
  def initialize(args)
    @base_url = args[:base_url]
    @url      = args[:url]
  end

  def scrape
    links.flat_map { |link| post_from(link) }
  end

  def links
    page_from(url).css('.hdrlnk').map do |link|
      format_link(link['href'])
    end
  end

  private

  attr_reader :base_url, :url

  def page_from(url)
    Nokogiri::HTML(open(url))
  end

  def format_link(link)
    if link =~ /\w+\.craig/
      'https:' + link
    else
      base_url + link
    end
  end

  def post_from(link)
    PostScraper.new(page_from(link), link).new_post
  end
end
