ActiveAdmin.register Playlist do

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
permit_params :collection_id , :date_time , :title_id

filter :title_film_title_cont, as: :select, collection: -> {Title.all.collect(&:film_title)}, label: "Title"
filter :collection_collection_name_eq, as: :select, collection: -> {Collection.all.collect(&:collection_name)}, label: "Collection"

index do
  binding.pry
  column :title do |col|
    col.title.film_title if col.title
  end
  column :collection do |col|
    col.collection.collection_name if col.collection
  end
  actions
end

end
