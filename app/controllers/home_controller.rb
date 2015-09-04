class HomeController < ApplicationController

def index

@connection = ActiveRecord::Base.establish_connection(
            :adapter => "mysql2",
            :host => "localhost",
            :database => "butaca_dev",
            :username => "root",
            :password => "1234"
)

  @films = @connection.connection.execute("SELECT collections.collection_name, collections.user_id, titles.filmTitle, titles.yearProduced, titles.id,titles.snappySummary, collections.featured FROM playlists LEFT OUTER JOIN collections ON playlists.collection_id = collections.id LEFT OUTER JOIN titles ON playlists.title_id = titles.id ");
end

end
