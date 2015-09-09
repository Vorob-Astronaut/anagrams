class SearchController < ApplicationController

  def search
    @q = Title.ransack params[:q]
    @titles = @q.result
  end

end
