class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

   before_filter :configure_permitted_parameters, if: :devise_controller?
   before_filter :set_locale
   before_filter :set_variables
   after_filter :clear_notice



    protected

    def clear_notice
      flash[:notice] = ''
      flash[:alert] = ''
    end

    def configure_permitted_parameters
        devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password) }
        devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :current_password, :is_female, :date_of_birth, :avatar, :notification_preferences ) }
    end

    private

  def set_variables
    @genre_list = Genre.all
    @country_list = Country.where(is_active?: true)
    @collection_list = Collection.all
    @q = Title.ransack params[:q]
    @last_notification = current_user.user_log_activities.unreaded if current_user
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def set_admin_locale
    I18n.locale = :en
  end


  def default_url_options(options = {})
    {locale: I18n.locale}
  end
end
