class HomeController < ApplicationController
  add_breadcrumb "home", :root_path

  def index
    @collections = Collection.all
  end

  def about
  end

end
