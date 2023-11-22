class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached  :photo
  # validates :full_name, presence: true

  # after_update_commit -> { check_which_broadcast } 

  def broadcast_photo_change
    if previous_changes['photo'].present?
      broadcast_updated_photo
    end
  end

  def broadcast_updated_photo
    broadcast_replace_to(
      "#{dom_id(self)}_photostream",
      partial: "users/photos/photo",
      locals: { user: self, scroll_to: true },
      target: dom_id(self, "photo")
    )
  end
end
