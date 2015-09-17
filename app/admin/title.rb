ActiveAdmin.register Title do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end

 permit_params :date_time, :film_title, :year_produced, :snappy_summary,:long_description_espanol,:key_art,:actors,:director,:imdb,:internal_comments,:butaca_owned,:short_description_espanol,:duration,:film_rating,:active,:meta_verified,:date_updated_can_istream, :locale,:country_titles_attributes => [:id,:country_id, :_destroy],:genre_titles_attributes => [:id,:genre_id , :_destroy]

 #controller do
  #def permitted_params
   # params.require(:title).permit(:id,:date_time, :filmTitle, :yearProduced, :snappySummary,:longDescriptionEspanol,:key_art,:Actors,:Director,:imdb,:internalComments,:butacaOwned,:shortDescriptionEspanol,:duration,:FilmRating,:active,:MetaVerified,:dateUpdatedCanIstream, :locale,:key_art_file_name, :key_art_content_type, :key_art_file_size, :key_art_updated_at,:country_titles_attributes => [:id,:country_id , :_destroy])
  #end
#end
filter :film_title_cont
filter :countries_country_cont, as: :select, collection: -> {Country.all.collect(&:country)}, label: "Country"
filter :genres_genre_espanol_cont, as: :select, collection: -> {Genre.all.collect(&:genre_espanol)}, label: "Genre es"
filter :genres_genre_english_cont, as: :select, collection: -> {Genre.all.collect(&:genre_english)}, label: "Genre en"

controller do
  def find_resource
    begin
      scoped_collection.where(slug: params[:id]).first!
    rescue ActiveRecord::RecordNotFound
      scoped_collection.find(params[:id])
    end
  end
end



form do |f|
  f.inputs
  f.inputs "key_art", :multipart => true  do
    f.input :key_art, :required => false, :as => :file , :hint => image_tag(f.object.key_art.url(:thumb))
  end

  f.has_many :country_titles ,  new_record: true,:allow_destroy => true do |p|
    p.input :country_id, label: 'Country', as: :select, collection: Country.all.map{|u| ["#{u.country}", u.id]}

  end
   f.has_many :genre_titles ,  new_record: true,:allow_destroy => true do |p|
    p.input :genre_id, label: 'Genre', as: :select, collection: Genre.all.map{|u| ["#{u.genre_espanol}", u.id]}

  end


  f.actions
 end

index do

    #column :id
    column :key_art do |coll|
      link_to image_tag(coll.key_art.url(:thumb)), "/admin/titles/#{coll.id}"
    end
    column :film_title
    column :year_produced
    column :director
    column :actors
    column :snappy_summary

    actions
end

show do |ad|
  attributes_table do
    row :key_art do
      image_tag(ad.key_art.url(:thumb))
    end
    row :date_time
    row :film_title
    row :date_updated_can_istream
    row :long_description_espanol
    row :year_produced
    row :snappy_summary
    row :director
    row :film_rating
    row :imdb
    row :short_description_espanol
    row :butaca_owned
    row :actors
    row :duration
    row :is_active?
    row :internal_comments
    row :meta_verified

    ad.genres.each do |genre|
      row :genre do genre.genre_espanol
    end
    end

     ad.countries.each do |country|
      row :country do country.country
     end

    end
    # Will display the image on show object page
  end
 end



end
