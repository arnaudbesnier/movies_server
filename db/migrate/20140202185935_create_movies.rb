class CreateMovies < ActiveRecord::Migration
  def up
    create_table :movies do |t|
      t.string   :alias
      t.string   :name
      t.string   :poster
      t.datetime :release_date
      t.string   :genre
      t.string   :duration
      t.text     :synopsis
      t.string   :director
      t.text     :actors
      t.string   :url_teaser
      t.string   :url_playlist
      t.boolean  :reviewed, default: false
    end
    add_index :movies, :alias,        unique: true
    add_index :movies, :url_teaser,   unique: true
    add_index :movies, :url_playlist, unique: true
  end

  def down
    drop_table :movies
  end
end
