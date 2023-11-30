module UsersHelper
  def photo_for(user)
    if user.photo.attached?
      image_tag user.photo.variant(resize_to_limit: [500, 500]), class: "profile__photo--img avatar-large"
    else
      content_tag(:div, "No photo added", class: "profile__photo--img avatar-large avatar-large--empty-state")
    end
  end

  def photo_edit_link_for(user)
    description = user.photo.attached? ? "Edit" : "Add"
    turbo_frame_tag "photo-form" do
      link_to "#{description == "Add" ? "+ " : ""}#{description} photo", edit_user_photo_path(user), data: { turbo_frame: "photo-form" }
    end
  end
end
