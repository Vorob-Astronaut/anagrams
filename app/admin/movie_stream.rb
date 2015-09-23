ActiveAdmin.register MovieStream do


  form do |f|
    inputs 'Details' do
      f.input :title, collection: Title.all.map{|t| [t.film_title, t.id]}
      f.input :typel
      f.input :link
      f.input :link_type
      f.input :price
      f.input :logo
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
