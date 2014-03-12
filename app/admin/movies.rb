# encoding: utf-8
include ApplicationHelper

ActiveAdmin.register Movie do

  actions :index, :edit, :update

  controller do

    def update
      update_from_button = params[:commit]
      validate_action = (update_from_button == 'Update & Validate')

      params[:movie][:reviewed] = true if validate_action

      update! do |format|
        if @movie.valid?
          if validate_action
            flash[:notice] = 'Movie was successfully validated.'
            format.html { redirect_to admin_movies_path }
          else
            flash[:notice] = 'Movie was successfully updated.'
            format.html { redirect_to edit_admin_movie_path(@movie) }
          end
        end
      end
    end

  end

  scope :reviewed
  scope :unreviewed, default: true

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
