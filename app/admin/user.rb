ActiveAdmin.register User do

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
permit_params :user_id,:email, :encrypted_password, :reset_password_token,:reset_password_sent_at,:remember_created_at,:current_sign_in_at,:last_sign_in_at,:current_sign_in_ip,:last_sign_in_ip, :avatar_file_name, :avatar_content_type, :avatar_file_size, :avatar_updated_at,:avatar, :name

controller do
  def notify
    count = 0
    User.all.each do |u|
      UserMailer.daily_mail(u).deliver_now
    end
    redirect_to(:back)
  end
end

form do |f|
  f.inputs
  f.inputs "Avatar", :multipart => true  do
    f.input :avatar, :required => false, :as => :file , :hint => image_tag(f.object.avatar.url(:thumb))

  end
  f.actions
 end

  index do
    column :email
    column :encrypted_password
    column :avatar do |coll|
      link_to image_tag(coll.avatar.url(:thumb)), "/admin/users/#{coll.id}"
    end
    actions
  end


  show do |ad|
  attributes_table do
    row :email
    row :encrypted_password
    row :sign_in_count
    row :current_sign_in_at
    row :last_sign_in_at
    row :current_sign_in_ip
    row :last_sign_in_ip
    row :image do
      image_tag(ad.avatar.url(:thumb))
    end
    # Will display the image on show object page
  end
 end

end
