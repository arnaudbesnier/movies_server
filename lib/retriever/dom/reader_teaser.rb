# encoding: utf-8

class ReaderTeaser

  URL_TEASER_SELECTOR = "//div[@class='yt-lockup-content']/h3/a/@href"

  def initialize body
    @body = body
  end

  def retrieve
    @url_teaser = @body.at_xpath(URL_TEASER_SELECTOR).to_s
    @url_teaser = nil if @url_teaser.empty?

    completed? ? response : nil
  end

  def response
    { url_teaser: "http://www.youtube.com#@url_teaser" }
  end

  def completed?
    !@url_teaser.nil?
  end

end
