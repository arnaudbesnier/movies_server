require 'retriever/url/requester'
require 'retriever/dom/reader_search'
require 'retriever/dom/reader_detail'
require 'retriever/dom/reader_teaser'
require 'retriever/dom/reader_playlist'

class Retriever

  URL_SEARCH_INFO       = 'http://www.allocine.fr/recherche/'
  URL_SEARCH_TEASER     = 'http://www.youtube.com/results?search_query'
  URL_SEARCH_SOUNDTRACK = 'http://www.youtube.com/?gl=FR&hl=fr'

  attr_reader :name, :alias, :name_formated, :response

  def initialize name
    @completed = false
    @name      = name.strip
    format_name
    @response = { alias: @alias }
  end

  def search
    begin

      # Movie informations & poster ============================================

      request = Requester.new "#{URL_SEARCH_INFO}?q=#{@name_formated}"
      request.read

      reader_search = ReaderSearch.new @name_formated, request.body
      reader_search.retrieve_detail_page

      request = Requester.new reader_search.detail_page
      request.read

      reader_detail = ReaderDetail.new request.body
      data_detail = reader_detail.retrieve

      return self if data_detail.nil?
      @response.merge! data_detail

      # Movie teaser ===========================================================

      request = Requester.new "#{URL_SEARCH_TEASER}=bande+annonce+#{@name_formated}+fr"
      request.parse

      reader_teaser = ReaderTeaser.new request.body_parsed
      data_teaser = reader_teaser.retrieve

      return self if data_teaser.nil?
      @response.merge! data_teaser

      # Movie playlist =========================================================

      request = Requester.new "#{URL_SEARCH_TEASER}=ost+#{@name_formated}"
      request.parse

      reader_playlist = ReaderPlaylist.new request.body_parsed
      data_playlist = reader_playlist.retrieve

      return self if data_playlist.nil?
      @response.merge! data_playlist

      @completed = true
      self

    rescue Exception => e
      puts "    ===> ERROR: #{e}"
      nil
    end
  end

  def completed?
    @completed
  end

private

  def format_name
    @name_formated = I18n.transliterate(@name.downcase)
    @name_formated = @name_formated.gsub(/$le /, '')
                                   .gsub('l\'', '')
                                   .gsub(':', '')
                                   .gsub('-', ' ')
                                   .gsub('d\'', '')
                                   .gsub('?', '').gsub('.', '')
                                   .squeeze(' ').gsub(' ', '+').gsub("'", '')
    @alias = @name_formated.gsub('+', '_')
  end

end
