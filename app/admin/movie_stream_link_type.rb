ActiveAdmin.register MovieStreamLinkType do
permit_params :typel, :logo
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
form do |f|
  f.inputs "Details" do
    f.input :typel
  end
  f.inputs "Logo", :multipart => true  do
    f.input :logo, :required => false, :as => :file , :hint => image_tag(f.object.logo.url(:medium))
  end
  f.actions
 end


end