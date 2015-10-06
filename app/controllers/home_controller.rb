class HomeController < ApplicationController
  add_breadcrumb "home", :root_path
  skip_before_filter :authenticate_admin_user!, :only => [:wellcome]

  def index
    @collections = Collection.all
  end

  def wellcome
    render layout: false
  end

  def about
  end

end
