# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140202185935) do

  create_table "movies", :force => true do |t|
    t.string   "alias"
    t.string   "name"
    t.string   "poster"
    t.datetime "release_date"
    t.string   "genre"
    t.string   "duration"
    t.text     "synopsis"
    t.string   "director"
    t.text     "actors"
    t.string   "url_teaser"
    t.string   "url_playlist"
    t.boolean  "reviewed",     :default => false
  end

  add_index "movies", ["alias"], :name => "index_movies_on_alias", :unique => true
  add_index "movies", ["url_playlist"], :name => "index_movies_on_url_playlist", :unique => true
  add_index "movies", ["url_teaser"], :name => "index_movies_on_url_teaser", :unique => true

end
