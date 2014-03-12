class Movie < ActiveRecord::Base

  attr_accessible :alias, :name, :poster, :release_date, :genre, :duration,
                  :synopsis, :director, :actors, :url_teaser, :url_playlist, :reviewed

  scope :reviewed,   -> { where(reviewed: true) }
  scope :unreviewed, -> { where(reviewed: false) }

  def csv_playlist
    url_playlist.gsub('http://www.youtube.com/playlist?list=PL', '')
  end

end
