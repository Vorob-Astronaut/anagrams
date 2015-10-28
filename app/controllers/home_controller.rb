class HomeController < ApplicationController
  add_breadcrumb "home", :root_path
  skip_before_filter :authenticate_admin_user!, only: [:welcome]

  def index
    @collections = Collection.all
  end

  def landing_page
    render layout: false
  end

  def about
  end
end
