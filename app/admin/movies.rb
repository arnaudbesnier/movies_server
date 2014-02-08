# encoding: utf-8
include ApplicationHelper

ActiveAdmin.register Movie do

  actions :index, :edit, :update

  scope :reviewed
  scope :unreviewed

  filter :name

  config.sort_order = :name_asc

  index do
    column :name,         sortable: :name
    column :director,     sortable: :director
    column(:release_date, sortable: :release_date) { |movie| format_date(movie.release_date) }
    column :genre,        sortable: :genre
    column('') { |movie| edit_link_icon(movie) }
  end

  form do |f|
    f.inputs 'story' do
      f.input :name
      f.input :genre
      f.input :synopsis
    end

    f.inputs 'infos' do
      f.input :director
      f.input :actors
      f.input :duration
      f.input :release_date
    end

    f.inputs 'links' do
      f.input :poster
      f.input :url_teaser
      f.input :url_playlist
    end

    f.inputs 'review' do
      f.input :reviewed
    end

    f.buttons
  end

end
