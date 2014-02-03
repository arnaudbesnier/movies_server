# encoding: utf-8

class ReaderSearch

  URL_DETAIL_INFO = 'http://www.allocine.fr'

  attr_accessor :detail_page, :movie_id

  def initialize movie_name, body
    #@movie_name = movie_name.gsub('+', '</b>\s*<b>')
    @body = body
  end

  def retrieve_detail_page
    regexp_info_page = /(\/film\/fichefilm_gen_cfilm=\d*.html)'>/i
    results   = @body.scan(regexp_info_page)
    #puts "===> INFOS : #{results.count} pages"
    detail_path = results.first.first
    @movie_id = detail_path.scan(/film\/fichefilm_gen_cfilm=(\d*).html/).first.first
    @detail_page = "#{URL_DETAIL_INFO}#{detail_path}"
  end

end
