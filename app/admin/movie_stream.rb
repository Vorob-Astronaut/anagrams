ActiveAdmin.register MovieStream do
permit_params :title_id, :typel, :link, :link_type, :price, :logo, :movie_stream_link_type_id, :protect

  form do |f|
    inputs 'Details' do
      f.input :title, collection: Title.all.order(:film_title).map{|t| [t.film_title, t.id]}
      f.input :typel, as: :select, collection: ['dvd', 'rental', 'purchase', 'streaming']
      f.input :link
      f.input :link_type, as: :select, collection:["amazon_dvd", "apple_itunes_rental", "apple_itunes_purchase", "android_rental", "amazon_prime_instant_video", "android_purchase", "netflix_instant", "amazon_video_rental", "amazon_video_purchase", "vudu_purchase", "fandor_streaming", "netflix_dvd", "amazon_bluray", "sony_purchase", "vudu_rental", "sony_rental", "hulu_movies"]
      f.input :movie_stream_link_type, as: :select, collection: MovieStreamLinkType.all.map{|u| ["#{u.typel}", u.id]}
      f.input :price
      f.input :protect
      f.actions
    end
  end



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


end
