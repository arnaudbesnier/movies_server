# encoding: utf-8

class ReaderPlaylist

  URL_PLAYLIST_SELECTOR = "//div[@class='yt-lockup-meta']/a/@href"

  def initialize body
    @body = body
  end

  def retrieve
    @url_playlist = @body.at_xpath(URL_PLAYLIST_SELECTOR).to_s
    @url_playlist.gsub!('/playlist?list=PL', '')
    @url_playlist = nil if @url_playlist.empty?

    completed? ? response : nil
  end

  def response
    { url_playlist: "http://gdata.youtube.com/feeds/api/playlists/#@url_playlist?alt=rss" }
  end

  def completed?
    !@url_playlist.nil?
  end

end
