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

  form partial: 'admin/movies/edit/general'

end
