# encoding: utf-8
include ApplicationHelper

ActiveAdmin.register Movie do

  actions :index, :edit, :update

  csv :force_quotes => true do
    column('media_ID')            { |movie| ''                 }
    column('media_ok')            { |movie| '0'                }
    column('media_type')          { |movie| 'film'             }
    column('media_titre')         { |movie| movie.name         }
    column('media_playlist')      { |movie| movie.csv_playlist }
    column('media_pseudo')        { |movie| 'admin'            }
    column('media_affiche')       { |movie| movie.poster       }
    column('media_date_sortie')   { |movie| movie.release_date }
    column('media_realisateurs')  { |movie| movie.director     }
    column('media_acteurs')       { |movie| movie.actors       }
    column('media_genre')         { |movie| movie.genre        }
    column('media_nationalite')   { |movie| ''                 }
    column('media_annonce')       { |movie| ''                 }
    column('media_nbSaison')      { |movie| ''                 }
    column('media_synopsis')      { |movie| movie.synopsis     }
    column('media_nbVisite')      { |movie| '0'                }
    column('media_date_ajout')    { |movie| ''                 }
    column('media_date_last_mod') { |movie| ''                 }
    column('media_nbCom')         { |movie| '0'                }
    column('media_lien_amazone')  { |movie| ''                 }
    column('media_etat')          { |movie| '1'                }
    column('media_supprimer')     { |movie| '0'                }
    column('media_youtube')       { |movie| movie.url_teaser   }
    column('media_youtube2')      { |movie| ''                 }
    column('media_youtube3')      { |movie| ''                 }
  end

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
