# encoding: utf-8

class ReaderDetail

  def initialize body
    @body = body
  end

  def retrieve
    begin
      retrieve_name
      retrieve_poster
      retrieve_release_date
      retrieve_genre
      retrieve_duration
      retrieve_synopsis
      retrieve_director
      retrieve_actors

      completed? ? response : nil
    rescue Exception => e
      puts "           ====> DETAIL RETRIEVER ERROR: #{e}"
      nil
    end
  end

private

  def search_field regexp
    data = @body.scan(regexp)
    return nil if data.nil? || data.first.nil?
    data.first.first
  end

  def retrieve_name
    regexp_info_name = /property\=\"og:title\"\ content\=\"(.*?)\"[\s\/\>|\/\>]/
    extracted_name   = search_field(regexp_info_name)
    @name            = extracted_name.nil? ? nil : extracted_name.gsub('&#39;', '\'')
  end

  def retrieve_poster
    regexp_info_poster = /property="og:image" content\=\"(.*?)\"[\s\/\>|\/\>]/
    @poster = search_field(regexp_info_poster)
  end

  def retrieve_release_date
    regexp_info_release_date = /<span itemprop=\"datePublished\".*>(.*)<\/span>/
    @release_date = search_field(regexp_info_release_date)
    format_release_date if @release_date
  end

  def format_release_date
    @release_date = @release_date.gsub(' janvier ', '/01/')
                                 .gsub(' février ', '/02/')
                                 .gsub(' mars ', '/03/')
                                 .gsub(' avril ', '/04/')
                                 .gsub(' mai ', '/05/')
                                 .gsub(' juin ', '/06/')
                                 .gsub(' juillet ', '/07/')
                                 .gsub(' août ', '/08/')
                                 .gsub(' septembre ', '/09/')
                                 .gsub(' octobre ', '/10/')
                                 .gsub(' novembre ', '/11/')
                                 .gsub(' décembre ', '/12/')
  end


  def retrieve_genre
    regexp_info_genre = /<span itemprop=\"genre\">([^<]*)<\/span>/
    @genre = search_field(regexp_info_genre)
  end

  def retrieve_duration
    regexp_info_duration = /<span itemprop="duration"[^>]*>(.*)<\/span>/
    @duration = search_field(regexp_info_duration)
  end

  def retrieve_synopsis
    regexp_info_synopsis = /<p itemprop="description">\s*(.*)/
    synopsis_unformated = search_field(regexp_info_synopsis)
    @synopsis = synopsis_unformated.nil? ? nil : format(synopsis_unformated)
  end

  def retrieve_director
    regexp_info_director = /<span itemprop=\"director\".*><a title=\"(.*)\" href=\"\/personne\/fichepersonne/
    @director = search_field(regexp_info_director)
  end

  def retrieve_actors
    regexp_info_actors = /<a title=\"([a-zA-Z\s]*)\" href=\"\/personne\/fichepersonne_gen_cpersonne/
    actors_unformated = @body.scan(regexp_info_actors).flatten[1..-1]
    @actors = actors_unformated.nil? ? nil : actors_unformated.join(', ')
  end

  def format html
    html.gsub(/<p[^>]*>/, '').gsub(/<\/p>/, '')
  end

  def response
    {
      name:         @name,
      poster:       @poster,
      release_date: @release_date,
      genre:        @genre,
      duration:     @duration,
      synopsis:     @synopsis,
      director:     @director,
      actors:       @actors
    }
  end

  def completed?
    !@name.nil? && !@poster.nil? && !@release_date.nil? && !@genre.nil? && !@duration.nil? && !@synopsis.nil? && !@director.nil? && !@actors.nil?
  end

  # def csv
  #   "\"#@name\", \"#@poster\", \"#@release_date\", \"#@genre\", \"#@duration\", \"#@synopsis\", \"#@director\", \"#@actors\""
  # end

end
