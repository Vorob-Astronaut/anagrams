class HomeController < ApplicationController
  add_breadcrumb "home", :root_path
  skip_before_filter :authenticate_admin_user!, only: [:welcome]
  http_basic_authenticate_with name: "admin", password: "passwd", only: [:welcome]

  def index
    @collections = Collection.all
  end

  def welcome
    render layout: false
  end

  def about
  end
end
