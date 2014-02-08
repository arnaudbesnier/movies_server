# encoding: utf-8
include ApplicationHelper

ActiveAdmin.register Movie do

  actions :index, :show

  scope :reviewed
  scope :unreviewed

  filter :name

  config.sort_order = :name_asc

  index do
    column :name,         sortable: :name
    column :director,     sortable: :director
    column(:release_date, sortable: :release_date) { |movie| format_date(movie.release_date) }
    column :genre,        sortable: :genre
  end

end
