Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get '/admin/admin_notify' => "admin/users#notify", as: "admin_notify"
  devise_for :users
 # root to: "home#index"
  devise_scope :user do
    get "/login" => "devise/sessions#new"
    get "/logout" => "devise/sessions#destroy"
  end
  get '/account' => 'users#show', as: :user_profile
 scope ':locale', locale: /es|en/ do
    resources :collections do
      get :follow, on: :member
    end
    resources :genre
    resources :countries
    resources :titles do
      get :follow, on: :member
    end
    resources :home
    resources :user_favorites
    resources :user_removals
    resources :user_queues
    get 'message' => 'user_activity_logs#send_message'
    root to: 'home#index'
  end
  get 'about' => 'home#about', as: :about
  get 'search' => 'search#search', as: :search
  get 'user/followed_collections' => 'users#followed_collections', as: :followed_collections
  get 'ac' => 'search#ac'
  get 'user_queues/add/:title_id' => 'user_queues#add', as: :add_to_que
  get 'user_favorites/add/:title_id' => 'user_favorites#add', as: :add_to_favorite
  get 'user_removals/add/:title_id' => 'user_removals#add', as: :add_to_removal
  get '*path', to: redirect("/#{I18n.default_locale}/%{path}")
  get '', to: redirect("/#{I18n.default_locale}")
  get '/:locale' => "home#index"
  post "add_a_film" => "users#add_a_film"
end
