# encoding: utf-8

ActiveAdmin.register Movie do

  actions :index, :show

  scope :reviewed
  scope :unreviewed

  filter :name

  config.sort_order = :name_asc

  index do
    column :name,         sortable: :name
    column :release_date, sortable: :release_date
    column :genre,        sortable: :genre
  end

end
