class GenreController < ApplicationController
  add_breadcrumb "home", :root_path
  add_breadcrumb "genres", :genre_index_path

   def index
     @genres = Genre.all
   end

  def show
    @genre = Genre.friendly.find(params[:id])
    add_breadcrumb @genre.genre_espanol, genre_path(@genre)
  end
end
