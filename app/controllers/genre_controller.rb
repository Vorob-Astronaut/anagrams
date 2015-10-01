class GenreController < ApplicationController
  add_breadcrumb "home", :root_path
  add_breadcrumb "genres", :genre_index_path

   def index
     @genres = Genre.all
   end

  def show
    @genre = Genre.friendly.find(params[:id])
    @titles = (@genre.titles-Title.in_removals(current_user)).paginate(page: params[:page], per_page: 5)
    add_breadcrumb @genre.genre_espanol, genre_path(@genre)
    if request.xhr?
      sleep(3) # make request a little bit slower to see loader
      render :partial => @titles
    end
  end
  
end
