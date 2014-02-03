class Movie < ActiveRecord::Base

  attr_accessible :alias, :name, :poster, :release_date, :genre, :duration,
                  :synopsis, :director, :actors, :url_teaser, :url_playlist

end
