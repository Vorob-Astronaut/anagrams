class HomeController < ApplicationController

  def index
    @collections = Collection.all
  end

  def about
  end

end
