class Movie < ActiveRecord::Base

  attr_accessible :alias, :name, :poster, :release_date, :genre, :duration,
                  :synopsis, :director, :actors, :url_teaser, :url_playlist

  scope :reviewed,   -> { where(reviewed: true) }
  scope :unreviewed, -> { where(reviewed: false) }

end
