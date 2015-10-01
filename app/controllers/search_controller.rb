class SearchController < ApplicationController

  def search
    @q = Title.ransack params[:q]
    @titles = @q.result
  end


  def ac
    @q = Title.ransack({'film_title_or_actors_or_director_cont' => params[:term]})
    @titles = @q.result.collect(&:film_title)
    respond_to do |format|
      format.json {render json: @titles}
    end
  end

end
