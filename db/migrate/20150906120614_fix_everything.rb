class FixEverything < ActiveRecord::Migration
  def change
    #rename section
    rename_column :titles, :keyArt, :key_art
    rename_column :titles, :internalComments, :internal_comments
    rename_column :titles, :butacaOwned, :butaca_owned
    rename_column :titles, :shortDescriptionEspanol, :short_description_espanol
    rename_column :titles, :FilmRating, :film_rating
    rename_column :titles, :MetaVerified, :meta_verified
    rename_column :titles, :dateUpdatedCanIstream, :date_updated_can_istream
    rename_column :titles, :keyArt_file_name, :key_art_file_name
    rename_column :titles, :keyArt_content_type, :key_art_content_type
    rename_column :titles, :keyArt_file_size, :key_art_file_size
    rename_column :titles, :keyArt_updated_at, :key_art_updated_at

    #change_types_section



  end
end
