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
      puts " ====> #{e}"
      nil
    end
  end

private

  def retrieve_name
    regexp_info_name = /property\=\"og:title\"\ content\=\"(.*?)\"[\s\/\>|\/\>]/
    # TODO: fix name format
    @name = @body.scan(regexp_info_name).first.first
  end

  def retrieve_poster
    regexp_info_poster = /property="og:image" content\=\"(.*?)\"[\s\/\>|\/\>]/
    @poster = @body.scan(regexp_info_poster).first.first
  end

  def retrieve_release_date
    regexp_info_release_date = /<span itemprop=\"datePublished\".*>(.*)<\/span>/
    @release_date = @body.scan(regexp_info_release_date).first.first
  end

  def retrieve_genre
    regexp_info_genre = /<span itemprop=\"genre\">([^<]*)<\/span>/
    @genre = @body.scan(regexp_info_genre).first.first
  end

  def retrieve_duration
    regexp_info_duration = /<span itemprop="duration"[^>]*>(.*)<\/span>/
    @duration = @body.scan(regexp_info_duration).first.first
  end

  def retrieve_synopsis
    # TODO: fix synopsis format
    regexp_info_synopsis = /<p itemprop="description">\s*(.*)/
    @synopsis = format(@body.scan(regexp_info_synopsis).first.first)
  end

  def retrieve_director
    regexp_info_director = /<span itemprop=\"director\".*><a title=\"(.*)\" href=\"\/personne\/fichepersonne/
    @director = @body.scan(regexp_info_director).first.first
  end

  def retrieve_actors
    # TODO: remove the director from the list (first element)
    regexp_info_actors = /<a title=\"([a-zA-Z\s]*)\" href=\"\/personne\/fichepersonne_gen_cpersonne/
    @actors = @body.scan(regexp_info_actors).flatten.join(', ')
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
