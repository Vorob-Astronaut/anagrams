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
 
 permit_params :date_time, :filmTitle, :yearProduced, :snappySummary,:longDescriptionEspanol,:key_art,:Actors,:Director,:imdb,:internalComments,:butacaOwned,:shortDescriptionEspanol,:duration,:FilmRating,:active,:MetaVerified,:dateUpdatedCanIstream, :locale,:country_titles_attributes => [:id,:country_id, :_destroy],:genre_titles_attributes => [:id,:genre_id , :_destroy]
 
 #controller do
  #def permitted_params
   # params.require(:title).permit(:id,:date_time, :filmTitle, :yearProduced, :snappySummary,:longDescriptionEspanol,:key_art,:Actors,:Director,:imdb,:internalComments,:butacaOwned,:shortDescriptionEspanol,:duration,:FilmRating,:active,:MetaVerified,:dateUpdatedCanIstream, :locale,:key_art_file_name, :key_art_content_type, :key_art_file_size, :key_art_updated_at,:country_titles_attributes => [:id,:country_id , :_destroy])
  #end
#end

form do |f|
  f.inputs
  f.inputs "key_art", :multipart => true  do 
    f.input :key_art, :required => false, :as => :file , :hint => image_tag(f.object.key_art.url(:thumb))
  end
  
  f.has_many :country_titles ,  new_record: true,:allow_destroy => true do |p|
    p.input :country_id, label: 'Country', as: :select, collection: Country.all.map{|u| ["#{u.country}", u.id]}
    
  end
   f.has_many :genre_titles ,  new_record: true,:allow_destroy => true do |p|
    p.input :genre_id, label: 'Genre', as: :select, collection: Genre.all.map{|u| ["#{u.genreEspanol}", u.id]}
    
  end
  
  
  f.actions
 end

index do
   
    #column :id
    column :key_art do |coll|
      link_to image_tag(coll.key_art.url(:thumb)), "/admin/titles/#{coll.id}"
    end
    column :filmTitle
    column :yearProduced
    column :Director
    column :Actors
    column :snappySummary
     
    actions
end
  
show do |ad|
  attributes_table do
    row :key_art do
      image_tag(ad.key_art.url(:thumb))
    end
    row :date_time
    row :filmTitle
    row :dateUpdatedCanIstream
    row :longDescriptionEspanol
    row :yearProduced
    row :snappySummary
    row :Director
    row :FilmRating
    row :imdb
    row :shortDescriptionEspanol
    row :butacaOwned
    row :Actors
    row :duration
    row :active
    row :internalComments
    row :MetaVerified
    
    ad.genres.each do |genre|
      row :genre do genre.genreEspanol
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
