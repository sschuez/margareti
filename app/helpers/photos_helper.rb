module PhotosHelper
  def photo_for(user)
    if user.photo.attached?
      if Rails.env.production?
        cl_image_tag(user.photo.key, {
          crop: :limit, width: 500, height: 500, class: "profile__photo--img avatar-large"
        })
      else
        # Here we use the default image_tag for development
        image_tag user.photo.variant(resize_to_limit: [500, 500]), class: "profile__photo--img avatar-large"
      end
    else
      content_tag(:div, "No photo added", class: "profile__photo--img avatar-large avatar-large--empty-state")
    end
  end
  
  def photo_edit_link_for(user)
    description = user.photo.attached? ? "Edit" : "Add"
    turbo_frame_tag "photo-form" do
      link_to "#{description == "Add" ? "+ " : ""}#{description} photo", edit_user_photo_path(user), data: { turbo_frame: "photo-form", controller: "action-authorisations", action_authorisations_target: "user" }
    end
  end
end