# Scrapes links and feeds them to PostScraper
class LinkScraper
  def initialize(url, base_url)
    @url = url
    @base_url = base_url
  end

  def links
    header_link.map { |link| format_link(link['href']) }
  end

  def posts
    links.flat_map { |link| post_from(link) }
  end

  private

  attr_reader :url, :base_url

  def page_from(url)
    Nokogiri::HTML(open(url))
  end

  def post_from(link)
    PostScraper.new(page_from(link), link).new_post
  end

  def header_link
    page_from(url).css('.hdrlnk')
  end

  def format_link(link)
    if link.match(/\w+\.craig/)
      link
      # 'https:' + link
    else
      base_url + link
    end
  end
end
